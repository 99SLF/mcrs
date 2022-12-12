package com.zimax.components.coframe.auth.controller;

import com.zimax.cap.party.Party;
import com.zimax.components.coframe.auth.service.PartyAuthService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 参与者授权
 *
 * @author 苏尚文
 * @date 2022/12/12 9:38
 */
@RestController
@RequestMapping("/party/auth")
public class PartyAuthController {

	/**
	 * 参与者授权服务
	 */
	@Autowired
	private PartyAuthService partyAuthService;

	/**
	 * 添加参与者授权
	 *
	 * @param partyTypeId 参与者类型
	 * @param id 参与者编号
	 * @param roleList 角色参与者列表
	 * @return
	 */
	@PostMapping("/add/{partyTypeId}/{id}")
	public Result<?> addPartyAuth(@PathVariable("partyTypeId") String partyTypeId, @PathVariable("id") String id, @RequestBody List<Party> roleList) {
		Party party = new Party(partyTypeId, id, null, null);
		return Result.success(partyAuthService.addOrUpdatePartyAuthBatch(roleList.toArray(new Party[roleList.size()]), party));
	}

	/**
	 * 删除参与者授权
	 *
	 * @param partyTypeId 参与者类型
	 * @param id 参与者编号
	 * @param roleList 角色参与者列表
	 * @return
	 */
	@PostMapping("/delete/{partyTypeId}/{id}")
	public Result<?> deletePartyAuth(@PathVariable("partyTypeId") String partyTypeId, @PathVariable("id") String id, @RequestBody List<Party> roleList) {
		Party party = new Party(partyTypeId, id, null, null);
		return Result.success(partyAuthService.delPartyAuthBatch(roleList.toArray(new Party[roleList.size()]), party));
	}

	/**
	 * 获取已授权的角色列表
	 *
	 * @param partyId 参与者编号
	 * @param partyType 参与者类型
	 * @return 已授权的角色列表
	 */
	@GetMapping("/authorized/{partyType}/{partyId}")
	public Result<?> getAuthorizedRoleList(@PathVariable("partyId") String partyId, @PathVariable("partyType") String partyType) {
		List<Party> authorizedRolePartyList = partyAuthService.getAuthorizedRoles(partyId, partyType);
		return Result.success(partyAuthService.convertToDataObjectList(authorizedRolePartyList));
	}

	/**
	 * 获取未授权角色列表
	 *
	 * @param partyId 参与者编号
	 * @param partyType 参与者类型
	 * @return 未授权角色列表
	 */
	@GetMapping("/unauthorized/{partyType}/{partyId}")
	public Result<?> getUnauthorizedRoleList(@PathVariable("partyId") String partyId, @PathVariable("partyType") String partyType) {
		return Result.success(partyAuthService.getUnauthorizedRoles(partyId, partyType));
	}

}
