package com.zimax.components.coframe.auth.party.manager;

import com.zimax.components.coframe.rights.mapper.UserMapper;
import com.zimax.components.coframe.rights.pojo.User;

/**
 * 默认的用户管理
 *
 * @author 苏尚文
 * @date 2022/12/12 11:09
 */
public class DefaultUserManager {

	// 默认用户管理Bean
	public static String SPRING_BEAN_NAME = "DefaultUserManagerBean";

	private final static String CAP_USER_ENTITY_USERID_PROPERTY = "userId";

	private UserMapper userMapper;

	public UserMapper getUserMapper() {
		return userMapper;
	}

	public void setUserMapper(UserMapper userMapper) {
		this.userMapper = userMapper;
	}

	/**
	 * 查询所有用户
	 *
	 * @return 所有用户数组
	 */
	public User[] getAllUserList() {
//		IDASCriteria criteria = DASManager.createCriteria(User.QNAME);
//		criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
//		return getDASTemplate().queryEntitiesByCriteriaEntity(User.class, criteria);
		return null;
	}

	/**
	 * 根据用户编号获取用户
	 *
	 * @param userId 用户编号
	 * @return 用户
	 */
	public User getUserByUserId(String userId) {
		return userMapper.getUserByUserId(userId);
	}

	/**
	 * 根据员工获取用户，使用查询实体
	 *
	 * @param empId    员工ID
	 * @param tenantID 租户ID
	 * @return 查询用户实体
	 */
//	public QueryUserByEmp getQueryUserByEmp(String empId, String tenantID) {
//		IDASCriteria criteria = DASManager.createCriteria(QueryUserByEmp.QNAME);
//		criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
//		criteria.add(ExpressionHelper.eq("empId", empId));
//		QueryUserByEmp[] queryUserArray = getDASTemplate().queryEntitiesByCriteriaEntity(QueryUserByEmp.class, criteria);
//		if (queryUserArray != null && queryUserArray.length == 1) {
//			return queryUserArray[0];
//		}
//		return null;
//	}

	/**
	 * 根据角色ID查询用户列表
	 *
	 * @param roleId   角色ID
	 * @param tenantID 租户ID
	 * @return 用户列表
	 */
//	public QueryUserByRole[] queryUserListByRoleId(String roleId, String tenantID) {
//		IDASCriteria criteria = DASManager.createCriteria(QueryUserByRole.QNAME);
//		criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
//		criteria.add(ExpressionHelper.eq("roleId", roleId));
//		criteria.add(ExpressionHelper.eq("partyType", IConstants.USER_PARTY_TYPE_ID));
//		return getDASTemplate().queryEntitiesByCriteriaEntity(QueryUserByRole.class, criteria);
//	}

	/**
	 * 根据用户ID查询员工和用户数组
	 *
	 * @param userId   用户ID
	 * @param tenantID 租户ID
	 * @return 员工和用户数组
	 */
//	public QueryEmpAndUserByUser[] queryEmpAndUserByUserId(String userId, String tenantID) {
//		IDASCriteria criteria = DASManager.createCriteria(QueryEmpAndUserByUser.QNAME);
//		criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
//		criteria.add(ExpressionHelper.eq("userId", userId));
//		return getDASTemplate().queryEntitiesByCriteriaEntity(QueryEmpAndUserByUser.class, criteria);
//	}

	/**
	 * 根据租户ID和用户ID查询员工数组
	 *
	 * @param userId
	 * @param tenantID
	 * @return
	 */
//	public Employee[] getEmpsByUserId(String userId, String tenantID) {
//		IDASCriteria criteria = DASManager.createCriteria(Employee.QNAME);
//		criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantID));
//		criteria.add(ExpressionHelper.eq(CAP_USER_ENTITY_USERID_PROPERTY, userId));
//		return getDASTemplate().queryEntitiesByCriteriaEntity(Employee.class, criteria);
//	}
}
