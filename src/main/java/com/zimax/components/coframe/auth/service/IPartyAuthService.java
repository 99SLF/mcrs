package com.zimax.components.coframe.auth.service;

import com.zimax.cap.party.Party;

import java.util.List;

/**
 * 参与者授权服务接口
 *
 * @author 苏尚文
 * @date 2022/12/12 9:53
 */
public interface IPartyAuthService {

	/**
	 * 获取已授权的角色列表
	 *
	 * @param partyId 参与者编号
	 * @param partyType 参与者类型
	 * @return 已授权的角色列表
	 */
	List<Party> getAuthorizedRoles(String partyId, String partyType);

	/**
	 * 获取未授权的角色列表
	 *
	 * @param partyId 参与者编号
	 * @param partyType 参与者类型
	 * @return 未授权的角色列表
	 */
	List<Party> getUnauthorizedRoles(String partyId, String partyType);

	/**
	 * 添加或修改某个参与者的角色映射
	 *
	 * @param roleList 角色列表
	 * @param currentParty 当前的参与者
	 * @return 是否成功
	 */
	boolean addOrUpdatePartyAuthBatch(Party[] roleList, Party currentParty);

	/**
	 * 删除某个参与者的角色列表
	 *
	 * @param roleList 角色列表
	 * @param currentParty 当前的参与者
	 * @return 是否成功
	 */
	boolean delPartyAuthBatch(Party[] roleList, Party currentParty);

}
