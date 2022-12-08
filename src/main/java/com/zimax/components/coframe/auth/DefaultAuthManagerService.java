package com.zimax.components.coframe.auth;

import com.alibaba.excel.util.StringUtils;
import com.zimax.cap.auth.AuthResource;
import com.zimax.cap.auth.IAuthManagerService;
import com.zimax.cap.auth.MenuTree;
import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.cap.party.Party;
import com.zimax.components.coframe.auth.menu.DefaultMenuAuthService;
import com.zimax.components.coframe.tools.IConstants;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.List;

/**
 * 默认授权管理实现，用于资源授权、参与者授权
 *
 * @author 苏尚文
 * @date 2022/12/6 14:26
 */
public class DefaultAuthManagerService implements IAuthManagerService {

    private Logger log = Logger.getLogger(DefaultAuthManagerService.class);

//    private DefaultResAuthManager resAuthBean = null;

//    private DefaultPartyAuthManager partyAuthBean = null;

    public DefaultAuthManagerService() {
//        BeanFactory beanFactory = BeanFactory.newInstance();
//        this.resAuthBean = beanFactory
//                .getBean(DefaultResAuthManager.SPRING_BEAN_NAME);
//        this.partyAuthBean = beanFactory
//                .getBean(DefaultPartyAuthManager.SPRING_BEAN_NAME);
    }

    public boolean addOrUpdateAuthRes(Party party, AuthResource authRes) {
        // 如果缓存中不存在，说明是要新增，否则是更新
//        String resId = authRes.getResourceId();
//        String resType = authRes.getResourceType();
//        try {
//            String state = AuthRuntimeManager.getInstance()
//                    .getAuthResourceState(party, resId, resType);
//            if (StringUtil.isEmpty(state)) {// 新增授权信息
//                ResAuth capResauth = ResAuth.FACTORY.create();
//                capResauth.setPartyId(party.getId());
//                capResauth.setPartyType(party.getPartyTypeID());
//                capResauth.setResId(resId);
//                capResauth.setResType(resType);
//                capResauth.setResState(authRes.getState());
//                capResauth.setCreateTime(new Date());
//                capResauth.setCreateUser(AppUserManager.getCurrentUserId());
//                capResauth.setTenantId(TenantManager.getCurrentTenantID());
//                this.resAuthBean.insertResAuth(capResauth);
//            } else {
//                ResAuth capResauth = this.resAuthBean
//                        .getResAuthByResIdAndType(party, resId, resType);
//                String newState = authRes.getState();
//                if (!newState.equals(capResauth.getResState())) {
//                    capResauth.setResState(newState);
//                    this.resAuthBean.updateResAuth(capResauth);
//                }
//            }
//            return true;
//        } catch (Throwable t) {
//            log.error("Add or update resource auth [resId=" + resId
//                    + ", resType=" + resType + "] failed.", t);
//            return false;
//        }
        return true;
    }

    public boolean addOrUpdateAuthResBatch(Party party,
                                           List<AuthResource> authResList) {
//        try {
//            List<ResAuth> toInsert = new ArrayList<ResAuth>();
//            List<ResAuth> toUpdate = new ArrayList<ResAuth>();
//            Map<String, Map<String, ResAuth>> tmpAuthTypeMap = new HashMap<String, Map<String, ResAuth>>();
//            for (AuthResource authResource : authResList) {
//                String resId = authResource.getResourceID();
//                String resType = authResource.getResourceType();
//                String state = AuthRuntimeManager.getInstance()
//                        .getAuthResourceState(party, resId, resType);
//                if (StringUtil.isEmpty(state)) {
//                    ResAuth capResAuth = ResAuth.FACTORY.create();
//                    capResAuth.setPartyId(party.getId());
//                    capResAuth.setPartyType(party.getPartyTypeID());
//                    capResAuth.setResId(resId);
//                    capResAuth.setResType(resType);
//                    capResAuth.setResState(authResource.getState());
//                    capResAuth.setCreateTime(new Date());
//                    capResAuth.setCreateUser(AppUserManager.getCurrentUserId());
//                    capResAuth.setTenantId(TenantManager.getCurrentTenantID());
//                    toInsert.add(capResAuth);
//                } else {
//                    // 如果需要更新的数据量很大，这里单个去查询可能会慢，一般来说批量更新的资源类型是相同的
//                    // 如果某种类型的资源授权信息很多，一次性查询出来处理也会比较慢，所以这里可能要根据实际资源类型分开处理
//                    Map<String, ResAuth> tmpAuthIdMap = tmpAuthTypeMap
//                            .get(resType);
//                    if (tmpAuthIdMap == null) {
//                        ResAuth[] resauths = this.resAuthBean
//                                .getResAuthListByResType(party, resType);
//                        tmpAuthIdMap = new HashMap<String, ResAuth>();
//                        for (ResAuth tmpResAuth : resauths) {
//                            tmpAuthIdMap.put(tmpResAuth.getResId(), tmpResAuth);
//                        }
//                        tmpAuthTypeMap.put(resType, tmpAuthIdMap);
//                    }
//                    ResAuth capResAuth = tmpAuthIdMap.get(resId);
//                    capResAuth.setResState(authResource.getState());
//                    toUpdate.add(capResAuth);
//                }
//            }
//
//            this.resAuthBean.save(
//                    toInsert.toArray(new ResAuth[toInsert.size()]),
//                    toUpdate.toArray(new ResAuth[toUpdate.size()]), null);
//
//            return true;
//        } catch (Throwable t) {
//            log.error("Add or update resources auth failed.", t);
//            return false;
//        }
        return true;
    }

    public boolean addOrUpdatePartyAuth(Party roleParty, Party party) {
//        try {
//            PartyAuth capPartyauth = PartyAuth.FACTORY.create();
//            capPartyauth.setRoleType(IConstants.ROLE_PARTY_TYPE_ID);
//            capPartyauth.setPartyId(party.getId());
//            capPartyauth.setPartyType(party.getPartyTypeID());
//            capPartyauth.setCreateUser(AppUserManager.getCurrentUserId());
//            capPartyauth.setCreateTime(new Date());
//            capPartyauth.setTenantId(TenantManager.getCurrentTenantID());
//            Role capRole = Role.FACTORY.create();
//            capRole.setRoleId(roleParty.getId());
//            capRole.setRoleCode(roleParty.getCode());
//            capRole.setRoleName(roleParty.getName());
//            capPartyauth.setRole(capRole);
//
//            this.partyAuthBean.savePartyAuth(capPartyauth);
//        } catch (Throwable t) {
//            log.error("insert partyAuth [rolePartyId=" + roleParty.getId()
//                    + ",partyId=" + party.getId() + "] failed.");
//            return false;
//        }
//        return true;
        return true;
    }

    public boolean addOrUpdatePartyAuthBatch(Party roleParty,
                                             List<Party> partyList) {
//        if (partyList == null) {
//            return false;
//        }
//        List<PartyAuth> capPartyAuthList = new ArrayList<PartyAuth>();
//
//        Role capRole = Role.FACTORY.create();
//        capRole.setRoleId(roleParty.getId());
//        capRole.setRoleCode(roleParty.getCode());
//        capRole.setRoleName(roleParty.getName());
//
//        try {
//            for (Party party : partyList) {
//                PartyAuth capPartyauth = PartyAuth.FACTORY.create();
//                capPartyauth.setRoleType(IConstants.ROLE_PARTY_TYPE_ID);
//                capPartyauth.setPartyId(party.getId());
//                capPartyauth.setPartyType(party.getPartyTypeID());
//                capPartyauth.setCreateUser(AppUserManager.getCurrentUserId());
//                capPartyauth.setCreateTime(new Date());
//                capPartyauth.setTenantId(TenantManager.getCurrentTenantID());
//
//                capPartyauth.setRole(capRole);
//                capPartyAuthList.add(capPartyauth);
//            }
//
//            this.partyAuthBean.savePartyAuthBatch(capPartyAuthList
//                    .toArray(new PartyAuth[capPartyAuthList.size()]));
//
//        } catch (Throwable t) {
//            log.error("insert partyAuth batch failed.");
//            return false;
//        }
//        return true;
        return true;
    }

    public boolean addOrUpdatePartyAuthBatch(List<Party> rolePartyList,
                                             Party party) {
//        if (rolePartyList == null) {
//            return false;
//        }
//        List<PartyAuth> capPartyAuthList = new ArrayList<PartyAuth>();
//        try {
//            for (Party roleParty : rolePartyList) {
//                PartyAuth capPartyauth = PartyAuth.FACTORY.create();
//                capPartyauth.setRoleType(IConstants.ROLE_PARTY_TYPE_ID);
//                capPartyauth.setPartyId(party.getId());
//                capPartyauth.setPartyType(party.getPartyTypeID());
//                capPartyauth.setCreateUser(AppUserManager.getCurrentUserId());
//                capPartyauth.setCreateTime(new Date());
//                capPartyauth.setTenantId(TenantManager.getCurrentTenantID());
//                Role capRole = Role.FACTORY.create();
//                capRole.setRoleId(roleParty.getId());
//                capRole.setRoleCode(roleParty.getCode());
//                capRole.setRoleName(roleParty.getName());
//                capPartyauth.setRole(capRole);
//                capPartyAuthList.add(capPartyauth);
//            }
//
//            this.partyAuthBean.savePartyAuthBatch(capPartyAuthList
//                    .toArray(new PartyAuth[capPartyAuthList.size()]));
//
//        } catch (Throwable t) {
//            log.error("insert partyAuth batch failed.");
//            return false;
//        }
//        return true;
        return true;
    }

    public boolean deletePartyAuth(String partyId, String partyType) {
//        String tenantId = TenantManager.getCurrentTenantID();
//        try {
//            this.partyAuthBean.deletePartyAuth(partyId, partyType, tenantId);
//            return true;
//        } catch (Throwable t) {
//            return false;
//        }
        return false;
    }

    public boolean delAuthRes(Party party, AuthResource authRes, int mode) {
//        String resId = authRes.getResourceID();
//        String resType = authRes.getResourceType();
//        try {
//            if (mode == IAuthManagerService.DEL_MODE_SINGLE) {// 删除一条记录
//                ResAuth capResauth = ResAuth.FACTORY.create();
//                capResauth.setPartyId(party.getId());
//                capResauth.setPartyType(party.getPartyTypeID());
//                capResauth.setResId(resId);
//                capResauth.setResType(resType);
//                this.resAuthBean.deleteResAuth(capResauth);
//            } else {
//                List<AuthResource> authResList = AuthRuntimeManager
//                        .getInstance().getAuthResListWithChildrenByRole(party,
//                                resId, resType);
//                // 这边目前和批量新增或更新一样，性能上可以有提升空间
//                List<ResAuth> toDel = new ArrayList<ResAuth>();
//                Map<String, Map<String, ResAuth>> tmpAuthTypeMap = new HashMap<String, Map<String, ResAuth>>();
//                for (AuthResource authResource : authResList) {
//                    String childResId = authResource.getResourceID();
//                    String childResType = authResource.getResourceType();
//                    Map<String, ResAuth> tmpAuthIdMap = tmpAuthTypeMap
//                            .get(childResType);
//                    if (tmpAuthIdMap == null) {
//                        ResAuth[] resauths = this.resAuthBean
//                                .getResAuthListByResType(party, childResType);
//                        tmpAuthIdMap = new HashMap<String, ResAuth>();
//                        for (ResAuth tmpResauth : resauths) {
//                            tmpAuthIdMap.put(tmpResauth.getResId(), tmpResauth);
//                        }
//                        tmpAuthTypeMap.put(childResType, tmpAuthIdMap);
//                    }
//                    ResAuth capResauth = tmpAuthIdMap.get(childResId);
//                    if (capResauth != null) {
//                        toDel.add(capResauth);
//                    }
//                }
//                this.resAuthBean.save(null, null,
//                        toDel.toArray(new ResAuth[toDel.size()]));
//            }
//
//            return true;
//        } catch (Throwable t) {
//            log.error("Delete resource auth [resId=" + resId + ", resType="
//                    + resType + ", mode=" + mode + "] failed.", t);
//            return false;
//        }
        return true;
    }

    public boolean delAuthResBatch(Party party, List<AuthResource> authResList,
                                   int mode) {
//        try {
//            Map<String, Map<String, ResAuth>> tmpAuthTypeMap = new HashMap<String, Map<String, ResAuth>>();
//            List<ResAuth> toDel = new ArrayList<ResAuth>();
//            if (mode == IAuthManagerService.DEL_MODE_SINGLE) {
//                for (AuthResource authRes : authResList) {
//                    String childResId = authRes.getResourceID();
//                    String childResType = authRes.getResourceType();
//                    Map<String, ResAuth> tmpAuthIdMap = tmpAuthTypeMap
//                            .get(childResType);
//                    if (tmpAuthIdMap == null) {
//                        ResAuth[] resauths = this.resAuthBean
//                                .getResAuthListByResType(party, childResType);
//                        tmpAuthIdMap = new HashMap<String, ResAuth>();
//                        for (ResAuth tmpResauth : resauths) {
//                            tmpAuthIdMap.put(tmpResauth.getResId(), tmpResauth);
//                        }
//                        tmpAuthTypeMap.put(childResType, tmpAuthIdMap);
//                    }
//                    ResAuth capResauth = tmpAuthIdMap.get(childResId);
//                    if (capResauth != null) {
//                        toDel.add(capResauth);
//                    }
//                }
//            } else {
//                for (AuthResource authRes : authResList) {
//                    String resId = authRes.getResourceID();
//                    String resType = authRes.getResourceType();
//                    List<AuthResource> authResListWithChildren = AuthRuntimeManager
//                            .getInstance().getAuthResListWithChildrenByRole(
//                                    party, resId, resType);
//                    for (AuthResource authResource : authResListWithChildren) {
//                        String childResId = authResource.getResourceID();
//                        String childResType = authResource.getResourceType();
//                        Map<String, ResAuth> tmpAuthIdMap = tmpAuthTypeMap
//                                .get(childResType);
//                        if (tmpAuthIdMap == null) {
//                            ResAuth[] resauths = this.resAuthBean
//                                    .getResAuthListByResType(party,
//                                            childResType);
//                            tmpAuthIdMap = new HashMap<String, ResAuth>();
//                            for (ResAuth tmpResauth : resauths) {
//                                tmpAuthIdMap.put(tmpResauth.getResId(),
//                                        tmpResauth);
//                            }
//                            tmpAuthTypeMap.put(childResType, tmpAuthIdMap);
//                        }
//                        ResAuth capResauth = tmpAuthIdMap.get(childResId);
//                        if (capResauth != null) {
//                            toDel.add(capResauth);
//                        }
//                    }
//                }
//            }
//            this.resAuthBean.save(null, null,
//                    toDel.toArray(new ResAuth[toDel.size()]));
//            return true;
//        } catch (Throwable t) {
//            log.error("Delete resources auth failed.", t);
//            return false;
//        }
        return true;
    }

    public boolean delPartyAuth(Party roleParty, Party party, int delMode) {
//        try {
//            if (delMode == IAuthManagerService.DEL_MODE_SINGLE) {
//                PartyAuth capPartyauth = PartyAuth.FACTORY.create();
//                capPartyauth.setRoleType(IConstants.ROLE_PARTY_TYPE_ID);
//                capPartyauth.setPartyId(party.getId());
//                capPartyauth.setPartyType(party.getPartyTypeID());
//                Role capRole = Role.FACTORY.create();
//                capRole.setRoleId(roleParty.getId());
//                capPartyauth.setRole(capRole);
//
//                this.partyAuthBean.deletePartyAuth(capPartyauth);
//            }
//        } catch (Throwable t) {
//            log.error("delete partyAuth [rolePartyId=" + roleParty.getId()
//                    + ",partyId=" + party.getId() + "] failed.");
//            return false;
//        }
//        return true;
        return true;
    }

    public boolean delPartyAuthBatch(Party roleParty, List<Party> partyList,
                                     int delMode) {
//        if (partyList == null) {
//            return false;
//        }
//        List<PartyAuth> capPartyAuthList = new ArrayList<PartyAuth>();
//
//        Role capRole = Role.FACTORY.create();
//        capRole.setRoleId(roleParty.getId());
//        capRole.setRoleCode(roleParty.getCode());
//        capRole.setRoleName(roleParty.getName());
//
//        try {
//            if (delMode == IAuthManagerService.DEL_MODE_SINGLE) {
//                for (Party party : partyList) {
//                    PartyAuth capPartyauth = PartyAuth.FACTORY.create();
//                    capPartyauth.setRoleType(IConstants.ROLE_PARTY_TYPE_ID);
//                    capPartyauth.setPartyId(party.getId());
//                    capPartyauth.setPartyType(party.getPartyTypeID());
//
//                    capPartyauth.setRole(capRole);
//                    capPartyAuthList.add(capPartyauth);
//                }
//
//                this.partyAuthBean.deletePartyAuthBatch(capPartyAuthList
//                        .toArray(new PartyAuth[capPartyAuthList.size()]));
//            }
//        } catch (Throwable t) {
//            log.error("delete partyAuth batch failed.");
//            return false;
//        }
//        return true;
        return true;
    }

    public boolean delPartyAuthBatch(List<Party> rolePartyList, Party party,
                                     int delMode) {
//        if (rolePartyList == null) {
//            return false;
//        }
//        List<PartyAuth> capPartyAuthList = new ArrayList<PartyAuth>();
//        try {
//            if (delMode == IAuthManagerService.DEL_MODE_SINGLE) {
//                for (Party roleParty : rolePartyList) {
//                    PartyAuth capPartyauth = PartyAuth.FACTORY.create();
//                    capPartyauth.setRoleType(IConstants.ROLE_PARTY_TYPE_ID);
//                    capPartyauth.setPartyId(party.getId());
//                    capPartyauth.setPartyType(party.getPartyTypeID());
//                    Role capRole = Role.FACTORY.create();
//                    capRole.setRoleId(roleParty.getId());
//                    capPartyauth.setRole(capRole);
//                    capPartyAuthList.add(capPartyauth);
//                }
//
//                this.partyAuthBean.deletePartyAuthBatch(capPartyAuthList
//                        .toArray(new PartyAuth[capPartyAuthList.size()]));
//            }
//        } catch (Throwable t) {
//            log.error("delete partyAuth batch failed.");
//            return false;
//        }
//        return true;
        return true;
    }

    public List<AuthResource> getAuthResListByRole(Party party) {
        // 返回一个测试列表
//        ResAuth[] resauths = this.resAuthBean
//                .getResAuthListByParty(party);
//        List<AuthResource> returnList = new ArrayList<AuthResource>();
//        if (resauths != null) {
//            for (ResAuth resauth : resauths) {
//                AuthResource authResource = new AuthResource(
//                        resauth.getResId(), resauth.getResType(),
//                        resauth.getResState());
//                returnList.add(authResource);
//            }
//        }
//        return returnList;
        return null;
    }

    public int getOrder() {
        // TODO Auto-generated method stub
        return 0;
    }

    public boolean delAuthResByRole(Party party) {
//        try {
//            this.resAuthBean.deleteResAuthByParty(party);
//            return true;
//        } catch (Throwable t) {
//            return false;
//        }
        return false;
    }

    public boolean delPartyAuthByRole(Party roleParty) {
//        try {
//            this.partyAuthBean.delPartyAuthByRole(roleParty);
//            return true;
//        } catch (Throwable t) {
//            return false;
//        }
        return false;
    }

    public MenuTree getUserMenuTree() {
        IUserObject userObject = DataContextManager.current()
                .getMUODataContext().getUserObject();
        String roleIds = (String) userObject
                .get(com.zimax.cap.auth.IConstants.ROLE_LIST);
        List<Party> roles = new ArrayList<Party>();
        if (roleIds != null) {
            String[] roleIdArr = roleIds
                    .split(com.zimax.cap.auth.IConstants.SPLIET);
            for (String roleId : roleIdArr) {
                if (!StringUtils.isEmpty(roleId)) {
                    roles.add(new Party(IConstants.ROLE_PARTY_TYPE_ID, roleId,
                            roleId, roleId));
                }
            }
        }
        DefaultMenuAuthService menuAuthService = new DefaultMenuAuthService(
                roles);
        return menuAuthService.getAllPartyAuthMenuTree();
    }

    public MenuTree getUserMenuTree(IMenuTreeFilter filter) {
        return filter.doFilter(getUserMenuTree());
    }

    public MenuTree getUserMenuTreeByAppCode(String appCode) {
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        String roleIds = (String) userObject
                .get(com.zimax.cap.auth.IConstants.ROLE_LIST);
        List<Party> roles = new ArrayList<Party>();
        if (roleIds != null) {
            String[] roleIdArr = roleIds.split(com.zimax.cap.auth.IConstants.SPLIET);
            for (String roleId : roleIdArr) {
                if (!StringUtils.isEmpty(roleId)) {
                    roles.add(new Party(IConstants.ROLE_PARTY_TYPE_ID, roleId,
                            roleId, roleId));
                }
            }
        }
        DefaultMenuAuthService menuAuthService = new DefaultMenuAuthService(
                roles, appCode);
        return menuAuthService.getAllPartyAuthMenuTree();
    }

}