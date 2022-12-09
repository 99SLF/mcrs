package com.zimax.components.coframe.auth.party.manager;

import com.zimax.cap.auth.manager.AuthRuntimeManager;
import com.zimax.cap.party.Party;
import com.zimax.cap.party.PartyType;
import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.components.coframe.tools.IConstants;

import java.util.ArrayList;
import java.util.List;

/**
 * 默认角色管理，提供对角色数据实体的数据库操作（持久化）
 *
 * @author 苏尚文
 * @date 2022/12/8 19:22
 */
public class DefaultRoleManager {

    private static String CAP_ROLE_ENTITY_ID_PROPERTY = "roleId";

    private static String CAP_ROLE_ENTITY_CODE_PROPERTY = "roleCode";

    private static String CAP_ROLE_ENTITY_NAME_PROPERTY = "roleName";

    public static String SPRING_BEAN_NAME = "DefaultRoleManagerBean";

    private static String CAP_PARTY_ID = "partyId";

    private static String CAP_PARTY_TYPE = "partyType";

    private final static String HAS_AUTH = "hasAuth";

    /**
     *
     */
    public DefaultRoleManager() {
    }

    public Role[] getAllRoleList() {
//        IDASCriteria criteria = DASManager.createCriteria(Role.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
//        return getDASTemplate().queryEntitiesByCriteriaEntity(Role.class,
//                criteria);
        return null;
    }

    public Role getRoleByRoleIDAndTenant(String roleID) {
//        IDASCriteria criteria = DASManager.createCriteria(Role.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
//        criteria.add(ExpressionHelper.eq(CAP_ROLE_ENTITY_ID_PROPERTY, roleID));
//        Role[] roles = getDASTemplate().queryEntitiesByCriteriaEntity(
//                Role.class, criteria);
//        if (roles != null && roles.length > 0) {
//            return roles[0];
//        }
        return null;
    }

    public Role getRoleByRoleID(String roleID) {
//        IDASCriteria criteria = DASManager.createCriteria(Role.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY,
//                TenantManager.getCurrentTenantID()));
//        criteria.add(ExpressionHelper.eq(CAP_ROLE_ENTITY_ID_PROPERTY, roleID));
//        Role[] roles = getDASTemplate().queryEntitiesByCriteriaEntity(
//                Role.class, criteria);
//        if (roles != null && roles.length > 0) {
//            return roles[0];
//        }
        return null;
    }

    /**
     * 用于授权界面的角色列表查询
     *
     * @param roleCode
     * @param roleName
     * @return
     */
//    public Role[] getRoleList(String roleCode, String roleName,
//                              DataObject pagecond) {
//        String tenantID = TenantManager.getCurrentTenantID();
//        IDASCriteria criteria = DASManager.createCriteria(Role.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
//        if (StringUtil.isNotEmpty(roleCode)) {
//            criteria.add(ExpressionHelper.like(CAP_ROLE_ENTITY_CODE_PROPERTY,
//                    "%" + roleCode + "%"));
//        }
//        if (StringUtil.isNotEmpty(roleName)) {
//            criteria.add(ExpressionHelper.like(CAP_ROLE_ENTITY_NAME_PROPERTY,
//                    "%" + roleName + "%"));
//        }
//        criteria.asc(CAP_ROLE_ENTITY_CODE_PROPERTY);
//        return getDASTemplate().queryEntitiesByCriteriaEntityWithPage(
//                Role.class, criteria, pagecond);
//
//    }

    /**
     * 根据角色代码判断是否已经存在
     *
     * @param roleCode
     * @return
     */
    public boolean isRoleCodeExist(String roleCode) {
//        String tenantID = TenantManager.getCurrentTenantID();
//        IDASCriteria criteria = DASManager.createCriteria(Role.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
//        criteria.add(ExpressionHelper.eq(CAP_ROLE_ENTITY_CODE_PROPERTY,
//                roleCode));
//        Role[] roles = getDASTemplate().queryEntitiesByCriteriaEntity(
//                Role.class, criteria);
//        if (roles != null && roles.length > 0) {
//            return true;
//        }
        return false;
    }

    public boolean insertRole(Role role) {
//        String tenantID = TenantManager.getCurrentTenantID();
//        role.setTenantId(tenantID);
//        role.setCreateTime(new Date());
//        role.setCreateUser(AppUserManager.getCurrentUserId());
//        try {
//            getDASTemplate().getPrimaryKey(role);
//            getDASTemplate().insertEntity(role);
//            return true;
//        } catch (Throwable t) {
//            return false;
//        }
        return false;
    }

    public boolean updateRole(Role role) {
//        String tenantID = TenantManager.getCurrentTenantID();
//        role.setTenantId(tenantID);
//        try {
//            getDASTemplate().updateEntity(role);
//            return true;
//        } catch (Throwable t) {
//            return false;
//        }
        return false;
    }

    public int deleteRole(String roleID) {
//        PartyType rolePartyType = AuthRuntimeManager.getInstance()
//                .getRolePartyType();
//        if (rolePartyType != null) {
//            String tenantID = TenantManager.getCurrentTenantID();
//            if (AuthRuntimeManager.getInstance().delRoleAuth(
//                    new Party(rolePartyType.getTypeID(), roleID, null, null,
//                            tenantID))) {
//                IDASCriteria criteria = DASManager
//                        .createCriteria(Role.QNAME);
//                criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY,
//                        tenantID));
//                criteria.add(ExpressionHelper.eq(CAP_ROLE_ENTITY_ID_PROPERTY,
//                        roleID));
//                int result = getDASTemplate().deleteByCriteriaEntity(criteria);
//                if (result != 0) {
//                    AuthRuntimeManager.getInstance().delRoleAuth(
//                            new Party(IConstants.ROLE_PARTY_TYPE_ID, roleID,
//                                    null, null, TenantManager
//                                    .getCurrentTenantID()));
//                    return result;
//                }
//            }
//        }
        return 0;
    }

    /**
     * 根据PartyID，PartyTypeID，租户获取其拥有的角色
     *
     * @param partyTypeId
     * @param partyId
     * @return
     */
    public Role[] getRoleListByAuthParty(String partyTypeId, String partyId) {
//        IDASCriteria criteria = DASManager.createCriteria(PartyAuth.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantId));
//        criteria.add(ExpressionHelper.eq(CAP_PARTY_ID, partyId));
//        criteria.add(ExpressionHelper.eq(CAP_PARTY_TYPE, partyTypeId));
//        criteria.addAssociation("role");
//        PartyAuth[] authRoles = getDASTemplate()
//                .queryEntitiesByCriteriaEntity(PartyAuth.class, criteria);
//        List<Role> returnList = new ArrayList<Role>();
//        if (authRoles != null) {
//            for (PartyAuth authRole : authRoles) {
//                returnList.add(authRole.getRole());
//            }
//        }
//        return returnList.toArray(new Role[returnList.size()]);
        return null;
    }

    /**
     * 通过传入多种party来获取拥有的角色列表
     *
     * @param partyTypeIdArray
     * @param partyIdArray
     * @param tenantId
     * @return
     */
    public Role[] getRoleListByAuthPartyList(String[] partyTypeIdArray, String[] partyIdArray) {
//        List<Role> returnList = new ArrayList<Role>();
//        if (partyTypeIdArray != null && partyIdArray != null
//                && partyIdArray.length == partyTypeIdArray.length) {
//            IDASCriteria criteria = DASManager
//                    .createCriteria(PartyAuth.QNAME);
//            criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY,
//                    tenantId));
//            Criterion criterion = null;
//            for (int i = 0; i < partyIdArray.length; i++) {
//                criterion = getIteratorCriterion(criterion, partyIdArray[i],
//                        partyTypeIdArray[i]);
//            }
//            criteria.add(criterion);
//            criteria.addAssociation("role");
//            PartyAuth[] authRoles = getDASTemplate()
//                    .queryEntitiesByCriteriaEntity(PartyAuth.class, criteria);
//
//            if (authRoles != null) {
//                for (PartyAuth authRole : authRoles) {
//                    returnList.add(authRole.getRole());
//                }
//            }
//        }
//
//        return returnList.toArray(new Role[returnList.size()]);
        return null;
    }

//    private Criterion getIteratorCriterion(Criterion criterion, String partyId,
//                                           String partyTypeId) {
//        if (criterion == null) {
//            return ExpressionHelper.and(
//                    ExpressionHelper.eq(CAP_PARTY_ID, partyId),
//                    ExpressionHelper.eq(CAP_PARTY_TYPE, partyTypeId));
//        } else {
//            return ExpressionHelper.or(criterion, ExpressionHelper.and(
//                    ExpressionHelper.eq(CAP_PARTY_ID, partyId),
//                    ExpressionHelper.eq(CAP_PARTY_TYPE, partyTypeId)));
//        }
//    }

    /**
     * 根据角色ID获取人员列表
     *
     * @param roleId
     *            角色ID
     * @return 人员列表
     */
//    public QueryEmpByRole[] queryEmpsByRoleId(String roleId, String tenantID) {
//        IDASCriteria criteria = DASManager.createCriteria(QueryEmpByRole.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
//        criteria.add(ExpressionHelper.eq("roleId", roleId));
//        criteria.add(ExpressionHelper.eq("partyType",
//                IConstants.EMP_PARTY_TYPE_ID));
//        criteria.asc("sortNo");
//        return getDASTemplate().queryEntitiesByCriteriaEntity(
//                QueryEmpByRole.class, criteria);
//    }

//    public Role[] queryRoleListByCriteria(CriteriaType criteriaType) {
//        IDASCriteria criteria = getDASTemplate().criteriaTypeToDASCriteria(
//                criteriaType);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY,
//                TenantManager.getCurrentTenantID()));
//        return getDASTemplate().queryEntitiesByCriteriaEntity(Role.class,
//                criteria);
//    }

    private boolean contain(Role[] authRoles, Role capRole) {
//        for (Role role : authRoles) {
//            if (role.getRoleId().equals(capRole.getRoleId())) {
//                return true;
//            }
//        }
        return false;
    }

    /**
     * 获取所有的Role 并根据partyId判断是否有改role的权限
     *
     * @param criteriaType
     * @param partyId
     * @param partyTypeId
     * @param isAuth
     * @return
     */
//    public Role[] queryRoleListByCriteriaWithAuthState(
//            CriteriaType criteriaType, String partyId, String partyTypeId,
//            String isAuth) {
//        Role[] roles = this.queryRoleListByCriteria(criteriaType);
//        Role[] authRoles = this.getRoleListByAuthParty(partyTypeId,
//                partyId, TenantManager.getCurrentTenantID());
//        List<Role> returnList = new ArrayList<Role>();
//        if (roles != null) {
//            for (Role role : roles) {
//                // 如果states中包含1，则有权限
//                if ("1".equals(isAuth)) {
//                    if (contain(authRoles, role)) {
//                        role.setString(HAS_AUTH, isAuth);
//                        returnList.add(role);
//                    }
//                } else if ("0".equals(isAuth)) {
//                    if (!contain(authRoles, role)) {
//                        role.setString(HAS_AUTH, isAuth);
//                        returnList.add(role);
//                    }
//                } else {
//                    if (contain(authRoles, role)) {
//                        role.setString(HAS_AUTH, "1");
//                    } else {
//                        role.setString(HAS_AUTH, "0");
//                    }
//                    returnList.add(role);
//                }
//            }
//        }
//        return returnList.toArray(new Role[returnList.size()]);
//    }

    /**
     * 批量删除角色
     *
     * @param roleId
     * @return
     */
    public String[] batchDeleteRole(String roleId) {
        List<String> list = new ArrayList<String>();
        if (roleId.contains(",")) {
            String[] roleIds = roleId.split(",");
            for (int i = 0; i < roleIds.length; i++) {
                int result = deleteRole(roleIds[i]);
                if (result != 1) {
                    list.add(roleIds[i]);
                }
            }
        } else {
            int result = deleteRole(roleId);
            if (result != 1) {
                list.add(roleId);
            }
        }
        return (String[]) list.toArray(new String[0]);
    }

    /**
     *
     * @param criteriaType
     *            查询条件
     * @param pageCond
     *            分页条件
     * @return 实体数组
     */
//    public Role[] queryRoles(CriteriaType criteriaType, PageCond pageCond) {
//        IDASCriteria dasCriteria = getDASTemplate().criteriaTypeToDASCriteria(
//                criteriaType);
//        return getDASTemplate().queryEntitiesByCriteriaEntityWithPage(
//                Role.class, dasCriteria, pageCond);
//    }

    /**
     *
     * @param capRoles
     *            实体数组,可以批量删除
     */
    public void deleteRole(Role[] capRoles) {
//        for (DataObject capRole : capRoles) {
//            getDASTemplate().deleteEntityCascade(capRole);
//        }
    }

    /**
     * 根据租户ID和角色ID获取机构列表
     *
     * @param roleId
     * @param tenantID
     * @return
     */
//    public QueryOrgByRole[] queryOrgsByRoleId(String roleId, String tenantID) {
//        IDASCriteria criteria = DASManager.createCriteria(QueryOrgByRole.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
//        criteria.add(ExpressionHelper.eq("roleId", roleId));
//        criteria.add(ExpressionHelper.eq("partyType",
//                IConstants.ORG_PARTY_TYPE_ID));
//        return getDASTemplate().queryEntitiesByCriteriaEntity(
//                QueryOrgByRole.class, criteria);
//    }

    /**
     * 根据租户ID和角色ID获取工作组列表
     *
     * @param roleId
     * @param tenantID
     * @return
     */
//    public QueryGroupByRole[] queryGroupsByRoleId(String roleId, String tenantID) {
//        IDASCriteria criteria = DASManager
//                .createCriteria(QueryGroupByRole.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
//        criteria.add(ExpressionHelper.eq("roleId", roleId));
//        criteria.add(ExpressionHelper.eq("partyType",
//                IConstants.GROUP_PARTY_TYPE_ID));
//        return getDASTemplate().queryEntitiesByCriteriaEntity(
//                QueryGroupByRole.class, criteria);
//    }

    /**
     * 根据租户ID和角色ID获取岗位列表
     *
     * @param roleId
     * @param tenantID
     * @return
     */
//    public QueryPositionByRole[] queryPositionsByRoleId(String roleId,
//                                                        String tenantID) {
//        IDASCriteria criteria = DASManager
//                .createCriteria(QueryPositionByRole.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
//        criteria.add(ExpressionHelper.eq("roleId", roleId));
//        criteria.add(ExpressionHelper.eq("partyType",
//                IConstants.POSITION_PARTY_TYPE_ID));
//        return getDASTemplate().queryEntitiesByCriteriaEntity(
//                QueryPositionByRole.class, criteria);
//    }
}