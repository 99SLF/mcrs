package com.zimax.components.coframe.auth.service;

import com.zimax.cap.auth.IAuthManagerService;
import com.zimax.cap.auth.manager.AuthRuntimeManager;
import com.zimax.cap.party.Party;
import com.zimax.cap.party.manager.PartyRuntimeManager;
import com.zimax.components.coframe.auth.pojo.PartyDataObject;
import com.zimax.components.coframe.rights.gradeauth.GradeAuthService;
import com.zimax.components.coframe.tools.IConstants;
import com.zimax.components.coframe.tools.service.ApplicationUtil;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.*;

/**
 * 参与者授权服务
 *
 * @author 苏尚文
 * @date 2022/12/12 9:59
 */
public class PartyAuthService implements IPartyAuthService {

	@Override
	public boolean addOrUpdatePartyAuthBatch(Party[] roleList, Party party) {
		if (roleList == null || roleList.length == 0 || party == null) {
			return false;
		}
		return AuthRuntimeManager.getInstance().addOrUpdatePartyAuthBatch(Arrays.asList(roleList), party);
	}

	@Override
	public boolean delPartyAuthBatch(Party[] roleList, Party party) {
		if (roleList == null || roleList.length == 0 || party == null) {
			return false;
		}
		return AuthRuntimeManager.getInstance().delPartyAuthBatch(Arrays.asList(roleList), party, IAuthManagerService.DEL_MODE_SINGLE);
	}

	@Override
	public List<Party> getAuthorizedRoles(String partyId, String partyType) {
		Party currentParty = PartyRuntimeManager.getInstance().getPartyByPartyID(partyId, partyType);
		List<Party> authorizedRolePartyList = AuthRuntimeManager.getInstance().getDirectRolePartyListByParty(currentParty);
		if (authorizedRolePartyList == null)
			return new ArrayList<Party>();

		// 可管理角色列表
		List<Party> managedRolePartyList = getGradeAuthService().getManagedRoleList();
		for (Party roleParty : authorizedRolePartyList) {
			roleParty.putExtAttribute(IConstants.IS_MANAGED, managedRolePartyList.contains(roleParty) ? "true" : "false");
		}

		return authorizedRolePartyList;
	}

	@Override
	public List<Party> getUnauthorizedRoles(String partyId, String partyType) {
		Party currentParty = PartyRuntimeManager.getInstance().getPartyByPartyID(partyId, partyType);
		List<Party> authorizedPartyList = AuthRuntimeManager.getInstance().getDirectRolePartyListByParty(currentParty);
		// 可管理角色列表
		List<Party> managedRolePartyList = getGradeAuthService().getManagedRoleList();
		if (managedRolePartyList == null) {
			return new ArrayList<Party>();
		}
		List<Party> unauthorizePartyList = new ArrayList<Party>();
		Set<String> authorizedPartyIdSet = new HashSet<String>();
		if (authorizedPartyList != null) {
			for (Party authorizedParty : authorizedPartyList) {
				authorizedPartyIdSet.add(authorizedParty.getId());
			}
		}
		// 排除已授权角色
		for (Party party : managedRolePartyList) {
			if (!authorizedPartyIdSet.contains(party.getId())) {
				unauthorizePartyList.add(party);
			}
		}
		return unauthorizePartyList;
	}

	public List<PartyDataObject> convertToDataObjectList(List<Party> partyList) {
		if (partyList == null || partyList.isEmpty()) {
			return Collections.emptyList();
		}

		List<PartyDataObject> partyDataObjectList = new ArrayList<PartyDataObject>(
				partyList.size());
		for (Party party : partyList) {
			partyDataObjectList.add(convertToDataObject(party));
		}
		return partyDataObjectList;
	}

	public PartyDataObject convertToDataObject(Party party) {
		PartyDataObject partyDataObject = new PartyDataObject();

		if (party == null)
			return partyDataObject;

		partyDataObject.setId(party.getId());
		partyDataObject.setCode(party.getCode());
		partyDataObject.setName(party.getName());
		partyDataObject.setIsManaged(party.getExtAttribute(IConstants.IS_MANAGED));

		return partyDataObject;
	}

	// GradeAuthBean在另一个构件包，所以直接用BeanFactory获取
	public GradeAuthService getGradeAuthService() {
		ApplicationContext context = ApplicationUtil.getInstance();
		return context.getBean(GradeAuthService.SPRING_BEAN_NAME, GradeAuthService.class);
	}
}
