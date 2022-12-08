package com.zimax.cap.auth.manager;

import com.zimax.cap.auth.AuthResource;
import com.zimax.cap.auth.IAuthManagerService;
import com.zimax.cap.auth.IAuthPoolManager;
import com.zimax.cap.auth.MenuTree;
import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.management.resource.IManagedResource;
import com.zimax.cap.management.resource.IResourceChangeEvent;
import com.zimax.cap.management.resource.IResourceChangeListener;
import com.zimax.cap.management.resource.impl.ResourceBean;
import com.zimax.cap.management.resource.manager.ResourceRuntimeManager;
import com.zimax.cap.party.Party;
import com.zimax.cap.party.PartyType;
import com.zimax.cap.party.PartyTypeRef;
import com.zimax.cap.party.impl.PartyTypeTreeModel;
import com.zimax.cap.party.manager.PartyRuntimeManager;
import com.zimax.cap.party.manager.PartyTypeManager;
import com.zimax.cap.utility.StringUtil;
import org.apache.log4j.Logger;

import java.util.*;

/**
 * 权限运行管理
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public class AuthRuntimeManager implements IResourceChangeListener {

    private Logger log = Logger.getLogger(AuthRuntimeManager.class);

    private Object lock = new Object();

    private static AuthRuntimeManager instance = null;

    private IAuthPoolManager authPoolManager = null;

    private AuthRuntimeManager() {
        initManagedResourceChangeListener();
        initAuthPoolManager();
    }

    private void initManagedResourceChangeListener() {
        ResourceRuntimeManager.getInstance().addResourceChangeListener(this);
    }

    private void initAuthPoolManager() {
        this.authPoolManager = new AuthPoolManager();
    }

    public static AuthRuntimeManager getInstance() {
        if (instance == null) {
            instance = new AuthRuntimeManager();
        }
        return instance;
    }

    public List<Party> getAllRolePartyList() {
        Map<String, PartyType> map = PartyTypeManager.getInstance()
                .getPartyTypeMap();

        Iterator<String> it = map.keySet().iterator();
        while (it.hasNext()) {
            String key = (String) it.next();
            PartyType partyType = (PartyType) map.get(key);
            if (partyType.isRole()) {
                return PartyTypeManager.getInstance()
                        .getPartyTypeDataService(key)
                        .getAllPartyList();
            }
        }
        return Collections.emptyList();
    }

    public List<AuthResource> getAuthResListByRole(Party roleParty) {
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return Collections.emptyList();
        }
        List<AuthResource> list = this.authPoolManager
                .getAuthResourceList(roleParty);
        if (list == null) {
            synchronized (this.lock) {
                list = this.authPoolManager.getAuthResourceList(roleParty);
                if (list == null) {
                    list = AuthManagerServiceLoader
                            .getCurrentPartyManagerService()
                            .getAuthResListByRole(roleParty);
                    this.authPoolManager.addAuthResourceList(roleParty, list);
                }
            }
        }
        return list;
    }

    public List<AuthResource> getAuthResListWithChildrenByRole(Party roleParty,
                                                               String resId, String resType) {
        if (resId == null) {
            this.log.error("The resId is null");
            return Collections.emptyList();
        }
        if (resType == null) {
            this.log.error("The resType is null");
            return Collections.emptyList();
        }
        List<AuthResource> returnList = new ArrayList();
        String[] xpath = ResourceRuntimeManager.getInstance()
                .getManagedResourceXpath(resId, resType);
        if (xpath != null) {
            IManagedResource managedResource = ResourceRuntimeManager
                    .getInstance().getManagedResource(xpath[0].split("/"),
                            xpath[1].split("/"));
            if (managedResource != null) {
                List<IManagedResource> managedResourceList = new ArrayList();
                collectResources(managedResource, managedResourceList);
                for (IManagedResource childResource : managedResourceList) {
                    String resourceID = childResource.getResourceID();
                    String resourceType = childResource.getResourceType();
                    String state = this.authPoolManager.getAuthResourceState(
                            roleParty, resourceID, resourceType);

                    returnList.add(new AuthResource(resourceID, resourceType,
                            state));
                }
            }
        }
        return returnList;
    }

    public List<AuthResource> getAuthResListByRole(Party roleParty,
                                                   String resourceType) {
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return Collections.emptyList();
        }
        if (resourceType == null) {
            this.log.error("The resourceType is null");
            return Collections.emptyList();
        }
        List<AuthResource> returnList = new ArrayList();
        List<AuthResource> list = this.authPoolManager
                .getAuthResourceList(roleParty);
        if (list == null) {
            list = getAuthResListByRole(roleParty);
        }
        for (AuthResource resource : list) {
            if (resourceType.equals(resource.getResourceType())) {
                returnList.add(resource);
            }
        }
        return returnList;
    }

    public String getAuthResourceState(Party roleParty, String resourceID,
                                       String resourceType) {
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return null;
        }
        if (resourceID == null) {
            this.log.error("The resourceID is null");
            return null;
        }
        if (resourceType == null) {
            this.log.error("The resourceType is null");
            return null;
        }
        List<AuthResource> list = this.authPoolManager
                .getAuthResourceList(roleParty);
        if (list == null) {
            list = getAuthResListByRole(roleParty);
        }
        String state = this.authPoolManager.getAuthResourceState(roleParty,
                resourceID, resourceType);
        if (state == null) {
            String[] xpath = ResourceRuntimeManager.getInstance()
                    .getManagedResourceXpath(resourceID, resourceType);
            if ((xpath != null) && (xpath.length == 2)) {
                IManagedResource managedResource = ResourceRuntimeManager
                        .getInstance().getManagedResource(xpath[0].split("/"),
                                xpath[1].split("/"));
                if (managedResource == null) {
                    return state;
                }
                if (managedResource.needAuth()) {
                    state = "";
                } else {
                    state = "__PUBLIC";
                }
            }
        }
        return state;
    }

    public List<Party> getPartyListByTypeWithRole(Party roleParty,
                                                  String partyTypeID) {
        List<Party> returnList = new ArrayList();
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return returnList;
        }
        if (partyTypeID == null) {
            this.log.error("The partyTypeID is null");
            return returnList;
        }
        PartyTypeTreeModel partyTypeTreeModel = PartyRuntimeManager
                .getInstance().getLoginPartyTypeTreeModel();

        List<PartyTypeTreeModel.PartyTypeTreeNode> rootPartyTreeNodeList = partyTypeTreeModel
                .getRootPartyTreeNode();

        PartyTypeTreeModel.PartyTypeTreeNode rootPartyTypeTreeNode = (PartyTypeTreeModel.PartyTypeTreeNode) rootPartyTreeNodeList
                .get(0);
        if (rootPartyTypeTreeNode != null) {
            iteratorAddPartyToList(returnList, rootPartyTypeTreeNode,
                    roleParty, partyTypeID);
        }
        return returnList;
    }

    private void iteratorAddPartyToList(List<Party> returnList,
                                        PartyTypeTreeModel.PartyTypeTreeNode partyTypeTreeNode,
                                        Party party, String partyTypeID) {
        if ((partyTypeID.equals(party.getPartyTypeId()))
                && (!returnList.contains(party))) {
            returnList.add(party);
        }
        if (partyTypeTreeNode.isSelfRelation()) {
            String selfRefID = partyTypeTreeNode.getSelfPartyTypeRefID();
            PartyTypeRef partyTypeRef = PartyRuntimeManager.getInstance()
                    .getPartyTypeRefByRefID(selfRefID);

            String childPartyTypeID = partyTypeRef.getChildPartyType()
                    .getTypeId();

            Map<String, List<Party>> map = PartyRuntimeManager.getInstance()
                    .getDirectAssociateChildPartyList(party.getId(),
                            new String[] { selfRefID });

            List<Party> partyList = (List) map.get(childPartyTypeID);
            if (partyList != null) {
                for (Party tmpParty : partyList) {
                    iteratorAddPartyToList(returnList, partyTypeTreeNode,
                            tmpParty, partyTypeID);
                }
            }
        }
        List<PartyTypeTreeModel.PartyTypeTreeNode> childrenPartyTypeTreeNodes = partyTypeTreeNode
                .getChildrenTypeTreeNode();
        Iterator i$;
        PartyTypeTreeModel.PartyTypeTreeNode childPartyTypeTreeNode;
        if (childrenPartyTypeTreeNodes != null) {
            for (i$ = childrenPartyTypeTreeNodes.iterator(); i$.hasNext();) {
                childPartyTypeTreeNode = (PartyTypeTreeModel.PartyTypeTreeNode) i$
                        .next();
                String refID = childPartyTypeTreeNode.getPartyTypeRefID();
                PartyTypeRef partyTypeRef = PartyRuntimeManager.getInstance()
                        .getPartyTypeRefByRefID(refID);

                String childPartyTypeID = partyTypeRef.getChildPartyType()
                        .getTypeId();

                Map<String, List<Party>> map = PartyRuntimeManager
                        .getInstance().getDirectAssociateChildPartyList(
                                party.getId(), new String[] { refID });

                List<Party> childPartyList = (List) map.get(childPartyTypeID);
                for (Party childParty : childPartyList) {
                    iteratorAddPartyToList(returnList, childPartyTypeTreeNode,
                            childParty, partyTypeID);
                }
            }
        }
    }

    public boolean addOrUpdateAuthRes(Party roleParty, AuthResource res) {
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return false;
        }
        if (res == null) {
            this.log.error("The authResource is null");
            return false;
        }
        if (AuthManagerServiceLoader.getCurrentPartyManagerService()
                .addOrUpdateAuthRes(roleParty, res)) {
            this.authPoolManager.addOrUpdateAuthResource(roleParty, res);
            return true;
        }
        return false;
    }

    public boolean addOrUpdateAuthResBatch(Party roleParty,
                                           List<AuthResource> authResList) {
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return false;
        }
        if (authResList == null) {
            this.log.error("The authResList is null");
            return false;
        }
        if (AuthManagerServiceLoader.getCurrentPartyManagerService()
                .addOrUpdateAuthResBatch(roleParty, authResList)) {
            for (AuthResource authResource : authResList) {
                this.authPoolManager.addOrUpdateAuthResource(roleParty,
                        authResource);
            }
            return true;
        }
        return false;
    }

    public boolean authResBatch(Party roleParty,
                                List<AuthResource> authResList, List<AuthResource> delRootResList) {
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return false;
        }
        boolean result = false;
        if (delRootResList != null) {
            result = AuthManagerServiceLoader.getCurrentPartyManagerService()
                    .delAuthResBatch(roleParty, delRootResList, 1);
        }
        if ((authResList != null) && (result)) {
            result = AuthManagerServiceLoader.getCurrentPartyManagerService()
                    .addOrUpdateAuthResBatch(roleParty, authResList);
        }
        if (result) {
            List<IManagedResource> managedResourceList = new ArrayList();
            for (AuthResource delAuthResource : delRootResList) {
                String resourceID = delAuthResource.getResourceId();
                String resourceType = delAuthResource.getResourceType();
                String[] xpath = ResourceRuntimeManager.getInstance()
                        .getManagedResourceXpath(resourceID, resourceType);
                if (xpath != null) {
                    IManagedResource rootManagedResource = ResourceRuntimeManager
                            .getInstance().getManagedResource(
                                    xpath[0].split("/"), xpath[1].split("/"));
                    if (rootManagedResource != null) {
                        collectResources(rootManagedResource,
                                managedResourceList);
                    }
                }
            }
            for (IManagedResource managedResource : managedResourceList) {
                this.authPoolManager.deleteAuthResource(roleParty,
                        new AuthResource(managedResource.getResourceID(),
                                managedResource.getResourceType()));
            }
            for (AuthResource authResource : authResList) {
                this.authPoolManager.addOrUpdateAuthResource(roleParty,
                        authResource);
            }
        }
        return result;
    }

    private void collectResources(IManagedResource managedResource,
                                  List<IManagedResource> managedResourceList) {
        if (managedResource == null) {
            return;
        }
        managedResourceList.add(managedResource);
        List<IManagedResource> childrenManagedResource = managedResource
                .getChildren();
        if (childrenManagedResource != null) {
            for (IManagedResource childManagedResource : childrenManagedResource) {
                collectResources(childManagedResource, managedResourceList);
            }
        }
    }

    public boolean delRoleAuth(Party roleParty) {
        if ((AuthManagerServiceLoader.getCurrentPartyManagerService()
                .delPartyAuthByRole(roleParty))
                && (AuthManagerServiceLoader.getCurrentPartyManagerService()
                .delAuthResByRole(roleParty))) {
            this.authPoolManager.deleteAuthResourceList(roleParty);
            return true;
        }
        return false;
    }

    public boolean delAuthRes(Party roleParty, AuthResource res, int delMode) {
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return false;
        }
        if (res == null) {
            this.log.error("The authResource is null");
            return false;
        }
        if (AuthManagerServiceLoader.getCurrentPartyManagerService()
                .delAuthRes(roleParty, res, delMode)) {
            if (delMode == 1) {
                List<IManagedResource> managedResourceList = new ArrayList();
                String resourceID = res.getResourceId();
                String resourceType = res.getResourceType();
                String[] xpath = ResourceRuntimeManager.getInstance()
                        .getManagedResourceXpath(resourceID, resourceType);
                if (xpath != null) {
                    IManagedResource rootManagedResource = ResourceRuntimeManager
                            .getInstance().getManagedResource(
                                    xpath[0].split("/"), xpath[1].split("/"));
                    if (rootManagedResource != null) {
                        collectResources(rootManagedResource,
                                managedResourceList);
                    }
                    for (IManagedResource managedResource : managedResourceList) {
                        this.authPoolManager.deleteAuthResource(
                                roleParty,
                                new AuthResource(managedResource
                                        .getResourceID(), managedResource
                                        .getResourceType()));
                    }
                }
                return true;
            }
            this.authPoolManager.deleteAuthResource(roleParty, res);
            return true;
        }
        return false;
    }

    public boolean delAuthResBatch(Party roleParty, List<AuthResource> resList,
                                   int delMode) {
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return false;
        }
        if (resList == null) {
            this.log.error("The authResourceList is null");
            return false;
        }
        if (AuthManagerServiceLoader.getCurrentPartyManagerService()
                .delAuthResBatch(roleParty, resList, delMode)) {
            if (delMode == 1) {
                List<IManagedResource> managedResourceList = new ArrayList();
                for (AuthResource authResource : resList) {
                    String resourceID = authResource.getResourceId();
                    String resourceType = authResource.getResourceType();
                    String[] xpath = ResourceRuntimeManager.getInstance()
                            .getManagedResourceXpath(resourceID, resourceType);
                    if (xpath != null) {
                        IManagedResource rootManagedResource = ResourceRuntimeManager
                                .getInstance().getManagedResource(
                                        xpath[0].split("/"),
                                        xpath[1].split("/"));
                        if (rootManagedResource != null) {
                            collectResources(rootManagedResource,
                                    managedResourceList);
                        }
                    }
                }
                for (IManagedResource managedResource : managedResourceList) {
                    this.authPoolManager.deleteAuthResource(roleParty,
                            new AuthResource(managedResource.getResourceID(),
                                    managedResource.getResourceType()));
                }
                return true;
            }
            for (AuthResource authResource : resList) {
                this.authPoolManager
                        .deleteAuthResource(roleParty, authResource);
            }
            return true;
        }
        return false;
    }

    public boolean addOrUpdatePartyAuth(Party roleParty, Party party) {
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return false;
        }
        if (party == null) {
            this.log.error("The party is null");
            return false;
        }
        return AuthManagerServiceLoader.getCurrentPartyManagerService()
                .addOrUpdatePartyAuth(roleParty, party);
    }

    public boolean addOrUpdatePartyAuthBatch(Party roleParty,
                                             List<Party> partyList) {
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return false;
        }
        if (partyList == null) {
            this.log.error("The partyList is null");
            return false;
        }
        return AuthManagerServiceLoader.getCurrentPartyManagerService()
                .addOrUpdatePartyAuthBatch(roleParty, partyList);
    }

    public boolean deletePartyAuth(String partyId, String partyType) {
        if (partyId == null) {
            this.log.error("The partyId is null");
            return false;
        }
        if (partyType == null) {
            this.log.error("The partyType is null");
            return false;
        }
        return AuthManagerServiceLoader.getCurrentPartyManagerService()
                .deletePartyAuth(partyId, partyType);
    }

    public boolean addOrUpdatePartyAuthBatch(List<Party> rolePartyList,
                                             Party party) {
        if (party == null) {
            this.log.error("The party is null");
            return false;
        }
        if (rolePartyList == null) {
            this.log.error("The rolePartyList is null");
            return false;
        }
        return AuthManagerServiceLoader.getCurrentPartyManagerService()
                .addOrUpdatePartyAuthBatch(rolePartyList, party);
    }

    public boolean delPartyAuth(Party roleParty, Party party, int delMode) {
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return false;
        }
        if (party == null) {
            this.log.error("The party is null");
            return false;
        }
        return AuthManagerServiceLoader.getCurrentPartyManagerService()
                .delPartyAuth(roleParty, party, delMode);
    }

    public boolean delPartyAuthBatch(Party roleParty, List<Party> partyList,
                                     int delMode) {
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return false;
        }
        if (partyList == null) {
            this.log.error("The roleParty is null");
            return false;
        }
        return AuthManagerServiceLoader.getCurrentPartyManagerService()
                .delPartyAuthBatch(roleParty, partyList, delMode);
    }

    public boolean delPartyAuthBatch(List<Party> rolePartyList, Party party,
                                     int delMode) {
        if (party == null) {
            this.log.error("The party is null");
            return false;
        }
        if (rolePartyList == null) {
            this.log.error("The rolePartyList is null");
            return false;
        }
        return AuthManagerServiceLoader.getCurrentPartyManagerService()
                .delPartyAuthBatch(rolePartyList, party, delMode);
    }

    public String[] getCurrentPartyResAuthState(String resId, String resType) {
        if (resId == null) {
            this.log.error("The resId is null");
            return null;
        }
        if (resType == null) {
            this.log.error("The resType is null");
            return null;
        }
        String roleList = getRoleListInMUO();
        List<String> stateList = new ArrayList();
        if (roleList != null) {
            PartyType rolePartyType = getRolePartyType();
            if (rolePartyType != null) {
                String[] roleArray = roleList.split(",");
                for (String role : roleArray) {
                    String state = getAuthResourceState(
                            new Party(rolePartyType.getTypeId(), role, null,
                                    null),
                            resId, resType);
                    if (!StringUtil.isEmpty(state)) {
                        stateList.add(state);
                    }
                }
            }
        }
        if (stateList.isEmpty()) {
            String[] xpath = ResourceRuntimeManager.getInstance()
                    .getManagedResourceXpath(resId, resType);
            if ((xpath == null) || (xpath.length == 0)) {
                return null;
            }
        }
        return (String[]) stateList.toArray(new String[stateList.size()]);
    }

    public Map<ResourceBean, String[]> getCurrentPartyResAuthWithChildren(
            String resId, String resType) {
        if (resId == null) {
            this.log.error("The resId is null");
            return Collections.emptyMap();
        }
        if (resType == null) {
            this.log.error("The resType is null");
            return Collections.emptyMap();
        }
        Map<ResourceBean, String[]> returnMap = new HashMap();

        String[] xpath = ResourceRuntimeManager.getInstance()
                .getManagedResourceXpath(resId, resType);
        if (xpath != null) {
            IManagedResource managedResource = ResourceRuntimeManager
                    .getInstance().getManagedResource(xpath[0].split("/"),
                            xpath[1].split("/"));
            if (managedResource != null) {
                List<IManagedResource> managedResourceList = new ArrayList();
                collectResources(managedResource, managedResourceList);
                for (IManagedResource childResource : managedResourceList) {
                    String childResourceID = childResource.getResourceID();
                    String childResourceType = childResource.getResourceType();
                    returnMap
                            .put(new ResourceBean(childResourceID,
                                            childResourceType),
                                    getCurrentPartyResAuthState(
                                            childResourceID, childResourceType));
                }
            }
        }
        return returnMap;
    }

    public Map<ResourceBean, String[]> getCurrentPartyResAuth(String resType) {
        if (resType == null) {
            this.log.error("The resType is null");
            return Collections.emptyMap();
        }
        String roleList = getRoleListInMUO();
        Map<ResourceBean, String[]> returnMap = new HashMap();
        if (roleList != null) {
            PartyType rolePartyType = getRolePartyType();
            if (rolePartyType != null) {
                String[] roleArray = roleList.split(",");
                for (String role : roleArray) {
                    List<AuthResource> authResourceList = getAuthResListByRole(
                            new Party(rolePartyType.getTypeId(), role, null, null), resType);
                    for (AuthResource authResource : authResourceList) {
                        String resourceID = authResource.getResourceId();
                        String resourceType = authResource.getResourceType();
                        ResourceBean resourceBean = new ResourceBean(
                                resourceID, resourceType);
                        String[] authStrArray = (String[]) returnMap
                                .get(resourceBean);
                        if (authStrArray != null) {
                            String[] newAuthStrArray = new String[authStrArray.length + 1];
                            System.arraycopy(authStrArray, 0, newAuthStrArray,
                                    0, authStrArray.length - 1);
                            newAuthStrArray[authStrArray.length] = authResource
                                    .getState();
                            returnMap.put(resourceBean, newAuthStrArray);
                        } else {
                            authStrArray = new String[] { authResource
                                    .getState() };
                            returnMap.put(resourceBean, authStrArray);
                        }
                    }
                }
            }
        }
        return returnMap;
    }

    private String getRoleListInMUO() {
        try {
            return (String) DataContextManager.current().getMUODataContext()
                    .getUserObject().get("roleList");
        } catch (Throwable t) {
        }
        return null;
    }

    public Map<ResourceBean, String[]> getCurrentPartyAuth() {
        String roleList = getRoleListInMUO();
        Map<ResourceBean, String[]> returnMap = new HashMap();
        if (roleList != null) {
            PartyType rolePartyType = getRolePartyType();
            if (rolePartyType != null) {
                String[] roleArray = roleList.split(",");
                for (String role : roleArray) {
                    List<AuthResource> authResourceList = getAuthResListByRole(new Party(
                            rolePartyType.getTypeId(), role, null, null));
                    for (AuthResource authResource : authResourceList) {
                        String resourceID = authResource.getResourceId();
                        String resourceType = authResource.getResourceType();
                        ResourceBean resourceBean = new ResourceBean(
                                resourceID, resourceType);
                        String[] authStrArray = (String[]) returnMap
                                .get(resourceBean);
                        if (authStrArray != null) {
                            String[] newAuthStrArray = new String[authStrArray.length + 1];
                            System.arraycopy(authStrArray, 0, newAuthStrArray,
                                    0, authStrArray.length - 1);
                            newAuthStrArray[authStrArray.length] = authResource
                                    .getState();
                            returnMap.put(resourceBean, newAuthStrArray);
                        } else {
                            authStrArray = new String[] { authResource
                                    .getState() };
                            returnMap.put(resourceBean, authStrArray);
                        }
                    }
                }
            }
        }
        return returnMap;
    }

    public PartyType getRolePartyType() {
        Map<String, PartyType> map = PartyTypeManager.getInstance()
                .getPartyTypeMap();

        Iterator<String> it = map.keySet().iterator();
        while (it.hasNext()) {
            String key = (String) it.next();
            PartyType partyType = (PartyType) map.get(key);
            if (partyType.isRole()) {
                return partyType;
            }
        }
        return null;
    }

    public void resourceChanged(IResourceChangeEvent resourceChangeEvent) {
        int changeType = resourceChangeEvent.getChangeType();
        List<AuthResource> authResourceList;
        List<AuthResource> toBeDeleteAuthResource;
        if (2 == changeType) {
            List<Party> rolePartyList = getAllRolePartyList();
            IManagedResource managedResource = resourceChangeEvent
                    .getOldValue();

            List<IManagedResource> managedResourceList = new ArrayList();
            collectResources(managedResource, managedResourceList);
            authResourceList = new ArrayList();
            for (IManagedResource childManagedResource : managedResourceList) {
                String resourceID = childManagedResource.getResourceID();
                String resourceType = childManagedResource.getResourceType();
                authResourceList
                        .add(new AuthResource(resourceID, resourceType));
            }
            for (Party roleParty : rolePartyList) {
                delAuthResBatch(roleParty, authResourceList, 0);
            }
        } else if (3 == changeType) {
            List<Party> rolePartyList = getAllRolePartyList();

            IManagedResource oldManagedResource = resourceChangeEvent
                    .getOldValue();
            IManagedResource newManagedResource = resourceChangeEvent
                    .getNewValue();

            List<IManagedResource> oldManagedResourceList = new ArrayList();
            collectResources(oldManagedResource, oldManagedResourceList);
            List<IManagedResource> newManagedResourceList = new ArrayList();
            collectResources(newManagedResource, newManagedResourceList);
            for (IManagedResource newChildResource : newManagedResourceList) {
                oldManagedResourceList.remove(newChildResource);
            }
            toBeDeleteAuthResource = new ArrayList();
            for (IManagedResource deleteResource : oldManagedResourceList) {
                String resourceID = deleteResource.getResourceID();
                String resourceType = deleteResource.getResourceType();
                toBeDeleteAuthResource.add(new AuthResource(resourceID,
                        resourceType));
            }
            for (Party roleParty : rolePartyList) {
                delAuthResBatch(roleParty, toBeDeleteAuthResource, 0);
            }
        }
    }

    public MenuTree getUserMenuTree() {
        return AuthManagerServiceLoader.getCurrentPartyManagerService()
                .getUserMenuTree();
    }

    public MenuTree getUserMenuTreeByAppCode(String appCode) {
        return AuthManagerServiceLoader.getCurrentPartyManagerService()
                .getUserMenuTreeByAppCode(appCode);
    }

    public MenuTree getUserMenuTree(IAuthManagerService.IMenuTreeFilter filter) {
        return AuthManagerServiceLoader.getCurrentPartyManagerService()
                .getUserMenuTree(filter);
    }

    public List<Party> getDirectRolePartyListByParty(Party party) {
        List<PartyTypeRef> partyTypeRefList = PartyRuntimeManager.getInstance()
                .getAllPartyTypeRefList();
        for (PartyTypeRef ref : partyTypeRefList) {
            PartyType parentPartyType = ref.getParentPartyType();
            if ((parentPartyType.isRole())
                    && (party.getPartyTypeId().equals(ref.getChildPartyType()
                    .getTypeId()))) {
                String refId = ref.getRefId();
                return (List) PartyRuntimeManager
                        .getInstance()
                        .getDirectAssociateParentPartyList(party.getId(),
                                new String[] { refId })
                        .get(parentPartyType.getTypeId());
            }
        }
        return Collections.EMPTY_LIST;
    }
}
