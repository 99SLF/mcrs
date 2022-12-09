package com.zimax.components.coframe.auth.service;

import com.zimax.cap.party.Party;

import java.util.List;

/**
 * 定义授权和party的接口类，根据用户ID获取所有的party及party关联的角色
 *
 * @author 苏尚文
 * @date 2022/12/8 18:23
 */
public interface IAuthPartyService {

    /**
     * 获取可继承权限的party的列表,根据该类型展开权限计算层级，譬如用户关联操作员，岗位关联职位，机构无关联
     *
     * @param partyId
     * @return
     */
    List<Party> getAssociateAuthPartyList(String partyId);

    /**
     * 获取直接授权的角色列表
     *
     * @param partyId
     * @return
     */
    List<Party> getAssociateAuthRoles(String partyId);

}
