package com.zimax.cap.management.resource.impl;

import com.zimax.cap.cache.CacheFactory;
import com.zimax.cap.cache.CacheProperty;
import com.zimax.cap.cache.ICache;
import com.zimax.cap.management.resource.IManagedResource;
import com.zimax.cap.management.resource.IResourceManagerService;
import com.zimax.cap.management.resource.util.ManagedResourceUtil;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author 苏尚文
 * @date 2022/12/6 16:32
 */
public class DefaultResourceManagerService implements IResourceManagerService {

    private Object lock = new Object();

    private int ADD_MODE = 0;

    private int DEL_MODE = 1;

    public static final String RESOUCE_CACHE_NAME = "com.zimes.cap.management.resource.cache";

    public static final String XPATH_CACHE_NAME = "com.zimes.cap.management.resource.xpath.cache";

    private ICache<String, Map<String, IManagedResource>> resourceMap = null;

    private ICache<ResourceBean, String[]> xpathMap = null;

    public DefaultResourceManagerService() {
        this.resourceMap = (ICache<String, Map<String, IManagedResource>>) CacheFactory
                .getInstance().findCache(RESOUCE_CACHE_NAME);
        if (this.resourceMap == null) {
            CacheProperty cacheProperty = CacheProperty
                    .newLocalCacheProperty(RESOUCE_CACHE_NAME);
            this.resourceMap = (ICache<String, Map<String, IManagedResource>>) CacheFactory
                    .getInstance().createCache(cacheProperty);
        }
        this.xpathMap = (ICache<ResourceBean, String[]>) CacheFactory
                .getInstance().findCache(XPATH_CACHE_NAME);
        if (this.xpathMap == null) {
            CacheProperty cacheProperty = CacheProperty
                    .newLocalCacheProperty(XPATH_CACHE_NAME);
            this.xpathMap = (ICache<ResourceBean, String[]>) CacheFactory
                    .getInstance().createCache(cacheProperty);
        }
    }

    public int getOrder() {
        return 10000;
    }

    public void registerManagedResource(IManagedResource managedResource) {
        String resourceType = managedResource.getResourceType();
        Map<String, IManagedResource> map = (Map) this.resourceMap
                .get(resourceType);
        if (map == null) {
            synchronized (this.lock) {
                map = (Map) this.resourceMap.get(resourceType);
                if (map == null) {
                    map = new ConcurrentHashMap();
                    this.resourceMap.put(resourceType, map);
                }
            }
        }
        map.put(managedResource.getResourceID(), managedResource);

        cacheXpath(managedResource, this.ADD_MODE);
    }

    public IManagedResource unRegisterManagedResource(String resourceID,
                                                      String resourceType) {
        Map<String, IManagedResource> map = (Map) this.resourceMap
                .get(resourceType);
        if (map != null) {
            IManagedResource removedManagedResource = (IManagedResource) map
                    .remove(resourceID);
            if (removedManagedResource != null) {
                cacheXpath(removedManagedResource, this.DEL_MODE);
            }
            return removedManagedResource;
        }
        return null;
    }

    private void cacheXpath(IManagedResource managedResource, int mode) {
        String resourceID = managedResource.getResourceID();
        String resourceType = managedResource.getResourceType();
        IManagedResource parentManagedResource = managedResource.getParent();
        if (mode == this.ADD_MODE) {
            if (parentManagedResource != null) {
                String parentResourceID = parentManagedResource.getResourceID();
                String parentResourceType = parentManagedResource
                        .getResourceType();
                String[] parentXpath = (String[]) this.xpathMap
                        .get(new ResourceBean(parentResourceID,
                                parentResourceType));

                String[] newXpath = new String[2];
                newXpath[0] = (parentXpath[0] + "/" + resourceID);
                newXpath[1] = (parentXpath[1] + "/" + resourceType);
                this.xpathMap.put(new ResourceBean(resourceID, resourceType),
                        newXpath);
            } else {
                String[] newXpath = { resourceID, resourceType };
                this.xpathMap.put(new ResourceBean(resourceID, resourceType),
                        newXpath);
            }
        } else {
            this.xpathMap.remove(new ResourceBean(resourceID, resourceType));
        }
        List<IManagedResource> childrenManagedResource = managedResource
                .getChildren();
        if (childrenManagedResource != null) {
            for (IManagedResource childManagedResource : childrenManagedResource) {
                cacheXpath(childManagedResource, mode);
            }
        }
    }

    public List<IManagedResource> getChildrenManagedResourceList(
            String[] resourceID, String[] resourceType) {
        int resourceIDLen = resourceID.length;
        if ((resourceIDLen > 0) && (resourceType.length == resourceIDLen)) {
            IManagedResource parentResource = getManagedResource(resourceID,
                    resourceType);
            if (parentResource != null) {
                return parentResource.getChildren();
            }
        }
        return Collections.emptyList();
    }

    public List<IManagedResource> getChildrenManagedResourceOfTypeList(
            String[] resourceID, String[] resourceType) {
        int resourceIDLen = resourceID.length;
        if ((resourceIDLen > 0) && (resourceType.length == resourceIDLen + 1)) {
            String[] newResourceType = new String[resourceIDLen];
            System.arraycopy(resourceType, 0, newResourceType, 0, resourceIDLen);

            IManagedResource parentResource = getManagedResource(resourceID,
                    newResourceType);
            if (parentResource != null) {
                return parentResource
                        .getChildrenOfType(resourceType[resourceIDLen]);
            }
        }
        return Collections.emptyList();
    }

    public IManagedResource getManagedResource(String[] resourceID,
                                               String[] resourceType) {
        int resourceIDLen = resourceID.length;
        Map<String, IManagedResource> actrualResourceMap = (Map) this.resourceMap
                .get(resourceType[0]);
        if (actrualResourceMap == null) {
            return null;
        }
        IManagedResource firstLevelResource = (IManagedResource) actrualResourceMap
                .get(resourceID[0]);
        if (resourceIDLen == 1) {
            return firstLevelResource;
        }
        Map<String, Map<String, IManagedResource>> tmpMap = firstLevelResource
                .getChildrenMap();
        if ((resourceIDLen > 0) && (resourceType.length == resourceIDLen)) {
            for (int i = 1; i < resourceIDLen; i++) {
                Map<String, IManagedResource> childActrualResourceMap = (Map) tmpMap
                        .get(resourceType[i]);
                if (childActrualResourceMap == null) {
                    return null;
                }
                IManagedResource managedResource = (IManagedResource) childActrualResourceMap
                        .get(resourceID[i]);
                if (i == resourceIDLen - 1) {
                    return managedResource;
                }
                if (managedResource == null) {
                    return null;
                }
                tmpMap = managedResource.getChildrenMap();
            }
        }
        return null;
    }

    public List<IManagedResource> getRootManagedResourceListByType(
            String resourceType) {
        Map<String, IManagedResource> map = (Map) this.resourceMap
                .get(resourceType);
        if (map != null) {
            List<IManagedResource> resourceList = new ArrayList();
            Iterator<String> it = map.keySet().iterator();
            while (it.hasNext()) {
                String resourceID = (String) it.next();
                resourceList.add(map.get(resourceID));
            }
            Collections.sort(resourceList, ManagedResourceUtil.getComparator());
            return resourceList;
        }
        return Collections.emptyList();
    }

    public String[] getManagedResourceXpath(String resourceID,
                                            String resourceType) {
        return (String[]) this.xpathMap.get(new ResourceBean(resourceID,
                resourceType));
    }
}
