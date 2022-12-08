package com.zimax.cap.management.resource.impl;

import com.zimax.cap.management.resource.IManagedResource;
import com.zimax.cap.management.resource.util.ManagedResourceUtil;
import com.zimax.cap.utility.StringUtil;
import org.apache.log4j.Logger;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author 苏尚文
 * @date 2022/12/7 14:52
 */
public final class DefaultManagedResource implements IManagedResource {

    private Logger log = Logger.getLogger(DefaultManagedResource.class);

    private Map<String, Map<String, IManagedResource>> childResourceMap = null;

    private Map<String, String> attributeMap = new HashMap();

    private String resourceID;

    private String resourceName;

    private String resourceType;

    private String resourceCatalog;

    private String resourceDesc;

    private String[] states;

    private IManagedResource parentManagedResource;

    private int order = 0;

    private boolean needCheck = true;

    public DefaultManagedResource(IManagedResource parentManagedResource,
                                  String resourceID, String resourceName, String[] states,
                                  String resourceType, String resouceCatalog, String resourceDesc) {
        if (StringUtil.isEmpty(resourceID)) {
            throw new ResourceRuntimeException("CAP_04110000");
        }
        if (StringUtil.isEmpty(resourceType)) {
            throw new ResourceRuntimeException("CAP_04110002",
                    new String[] { resourceID });
        }
        if (StringUtil.isEmpty(resourceName)) {
            throw new ResourceRuntimeException("CAP_04110001",
                    new String[] { resourceID });
        }
        this.parentManagedResource = parentManagedResource;
        this.resourceID = resourceID;
        this.resourceName = resourceName;
        this.states = states;
        this.resourceType = resourceType;
        this.resourceCatalog = resouceCatalog;
        this.resourceDesc = resourceDesc;
        if (this.parentManagedResource != null) {
            this.parentManagedResource.addChildManagedResource(this);
        }
    }

    public DefaultManagedResource(IManagedResource parentManagedResource,
                                  String resourceID, String resourceName, String[] states,
                                  String resourceType, String resouceCatalog, String resourceDesc,
                                  boolean needCheck) {
        this(parentManagedResource, resourceID, resourceName, states,
                resourceType, resouceCatalog, resourceDesc);

        this.needCheck = needCheck;
    }

    public DefaultManagedResource(IManagedResource parentManagedResource,
                                  String resourceID, String resourceName, String[] states,
                                  String resourceType, String resouceCatalog, String resourceDesc,
                                  int order) {
        this(parentManagedResource, resourceID, resourceName, states,
                resourceType, resouceCatalog, resourceDesc);

        this.order = order;
    }

    public DefaultManagedResource(IManagedResource parentManagedResource,
                                  String resourceID, String resourceName, String[] states,
                                  String resourceType, String resouceCatalog, String resourceDesc,
                                  int order, boolean needCheck) {
        this(parentManagedResource, resourceID, resourceName, states,
                resourceType, resouceCatalog, resourceDesc, order);

        this.needCheck = needCheck;
    }

    public List<IManagedResource> getChildren() {
        if (this.childResourceMap != null) {
            List<IManagedResource> resourceList = new ArrayList();
            Iterator<String> it = this.childResourceMap.keySet().iterator();
            while (it.hasNext()) {
                String typeKey = (String) it.next();
                Map<String, IManagedResource> acturalResourceMap = (Map) this.childResourceMap
                        .get(typeKey);
                Iterator<String> itActural = acturalResourceMap.keySet()
                        .iterator();
                while (itActural.hasNext()) {
                    String resourceID = (String) itActural.next();
                    resourceList.add(acturalResourceMap.get(resourceID));
                }
            }
            Collections.sort(resourceList, ManagedResourceUtil.getComparator());
            return resourceList;
        }
        return Collections.emptyList();
    }

    public List<IManagedResource> getChildrenOfType(String type) {
        if (this.childResourceMap != null) {
            List<IManagedResource> resourceList = new ArrayList();

            Map<String, IManagedResource> acturalResourceMap = (Map) this.childResourceMap
                    .get(type);
            if (acturalResourceMap != null) {
                Iterator<String> it = acturalResourceMap.keySet().iterator();
                while (it.hasNext()) {
                    String key = (String) it.next();
                    resourceList.add(acturalResourceMap.get(key));
                }
            }
            Collections.sort(resourceList, ManagedResourceUtil.getComparator());
            return resourceList;
        }
        return Collections.emptyList();
    }

    public boolean hasChildren() {
        if (this.childResourceMap != null) {
            return !this.childResourceMap.isEmpty();
        }
        return false;
    }

    public void addChildManagedResource(IManagedResource managedResource) {
        if (this.childResourceMap == null) {
            this.childResourceMap = new ConcurrentHashMap();
        }
        Map<String, IManagedResource> actualResourceMap = (Map) this.childResourceMap
                .get(managedResource.getResourceType());
        if (actualResourceMap == null) {
            actualResourceMap = new ConcurrentHashMap();
            this.childResourceMap.put(managedResource.getResourceType(),
                    actualResourceMap);
        }
        if (actualResourceMap.containsKey(managedResource.getResourceID())) {
            this.log.warn("The child resource [resourceID="
                    + managedResource.getResourceID() + ",resourceType="
                    + managedResource.getResourceType()
                    + "] has existed in the parent resource [resourceID="
                    + getResourceID() + ",resourceType=" + getResourceType()
                    + "]");
        }
        actualResourceMap.put(managedResource.getResourceID(), managedResource);
    }

    public IManagedResource removeChildManagedResource(String resourceID,
                                                       String resourceType) {
        if (this.childResourceMap != null) {
            Map<String, IManagedResource> actualResourceMap = (Map) this.childResourceMap
                    .get(resourceType);
            if (actualResourceMap != null) {
                IManagedResource removedResource = (IManagedResource) actualResourceMap
                        .remove(resourceID);
                if (removedResource != null) {
                    return removedResource;
                }
            }
        }
        this.log.warn("The child resource [resourceID=" + resourceID
                + ",resourceType=" + resourceType
                + "] does not exist in the parent resource [resourceID="
                + getResourceID() + ",resourceType=" + getResourceType() + "]");
        return null;
    }

    public void updateChildManagedResource(IManagedResource managedResource) {
        if (this.childResourceMap != null) {
            String resourceType = managedResource.getResourceType();
            if (this.childResourceMap.containsKey(resourceType)) {
                Map<String, IManagedResource> actualResourceMap = (Map) this.childResourceMap
                        .get(resourceType);
                String resourceID = managedResource.getResourceID();
                if (actualResourceMap.containsKey(resourceID)) {
                    actualResourceMap.put(managedResource.getResourceID(),
                            managedResource);

                    return;
                }
            }
        }
        this.log.warn("The child resource [resourceID="
                + managedResource.getResourceID() + ",resourceType="
                + managedResource.getResourceType()
                + "] does not exist in the parent resource [resourceID="
                + getResourceID() + ",resourceType=" + getResourceType() + "]");
    }

    public IManagedResource getParent() {
        return this.parentManagedResource;
    }

    public int getOrder() {
        return this.order;
    }

    public String getResourceDesc() {
        return this.resourceDesc;
    }

    public String getResourceID() {
        return this.resourceID;
    }

    public String getResourceName() {
        return this.resourceName;
    }

    public String getResourceType() {
        return this.resourceType;
    }

    public String[] getStateList() {
        return this.states;
    }

    public String getResourceCatalog() {
        return this.resourceCatalog;
    }

    public Map<String, Map<String, IManagedResource>> getChildrenMap() {
        return this.childResourceMap;
    }

    public boolean needAuth() {
        return this.needCheck;
    }

    public boolean equals(Object other) {
        DefaultManagedResource otherNode = (DefaultManagedResource) other;
        if ((Objects.equals(this.resourceID, otherNode.resourceID))
                && (Objects.equals(this.resourceType,
                otherNode.resourceType))) {
            return true;
        }
        return false;
    }

    public int hashCode() {
        int PRIME = 31;
        int result = 1;
        result = 31 * result
                + (this.resourceID == null ? 0 : this.resourceID.hashCode());
        result = 31
                * result
                + (this.resourceType == null ? 0 : this.resourceType.hashCode());
        return result;
    }

    public void addAttribute(String key, String value) {
        this.attributeMap.put(key, value);
    }

    public String getAttribute(String key) {
        return (String) this.attributeMap.get(key);
    }

    public void removeAttribute(String key) {
        this.attributeMap.remove(key);
    }
}
