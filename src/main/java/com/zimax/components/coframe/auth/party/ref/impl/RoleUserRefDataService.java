package com.zimax.components.coframe.auth.party.ref.impl;

import com.zimax.cap.party.IPartyTypeRefDataService;
import com.zimax.cap.party.Party;
import com.zimax.components.coframe.auth.party.manager.DefaultRoleManager;
import com.zimax.components.coframe.auth.party.manager.DefaultUserManager;
import com.zimax.components.coframe.framework.IFunctionService;
import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.components.coframe.tools.IConstants;
import com.zimax.components.coframe.tools.service.ApplicationUtil;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.ArrayList;
import java.util.List;

/**
 * 角色和用户的关系描述(角色为父，用户为子)
 *
 * @author 苏尚文
 * @date 2022/12/12 14:19
 */
public class RoleUserRefDataService implements IPartyTypeRefDataService {

	// 角色Bean
	private DefaultRoleManager roleBean = null;

	// 用户Bean
	private DefaultUserManager userBean = null;

	/**
	 * 构造方法
	 */
	public RoleUserRefDataService() {
		ApplicationContext context = ApplicationUtil.getInstance();
		this.roleBean = context.getBean(DefaultRoleManager.SPRING_BEAN_NAME, DefaultRoleManager.class);
		this.userBean = context.getBean(DefaultUserManager.SPRING_BEAN_NAME, DefaultUserManager.class);
	}

	@Override
	public List<Party> getChildrenPartyList(String parentPartyId) {
		// 根据角色获取用户
		List<Party> returnList = new ArrayList<Party>();
//		QueryUserByRole[] queryUserByRoles = this.userBean
//				.queryUserListByRoleId(parentPartyID, tenantID);
//		if (queryUserByRoles != null) {
//			for (QueryUserByRole queryUserByRole : queryUserByRoles) {
//				Party party = new Party(IConstants.USER_PARTY_TYPE_ID,
//						queryUserByRole.getUserId(), null,
//						queryUserByRole.getUserName(),
//						queryUserByRole.getTenantId());
//				party.putExtAttribute(IConstants.EMAIL,
//						queryUserByRole.getEmail());
//				returnList.add(party);
//			}
//		}
		return returnList;
	}

	@Override
	public List<Party> getParentPartyList(String childPartyId) {
		// 根据用户获取角色
		List<Party> returnList = new ArrayList<Party>();
		Role[] roleArray = this.roleBean.getRoleListByAuthParty(IConstants.USER_PARTY_TYPE_ID, childPartyId);
		if (roleArray != null) {
			for (Role role : roleArray) {
				returnList.add(new Party(IConstants.ROLE_PARTY_TYPE_ID, String.valueOf(role.getRoleId()), role.getRoleCode(), role.getRoleName()));
			}
		}
		return returnList;
	}

}