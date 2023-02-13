package com.zimax.components.coframe.rights.pojo;

import lombok.Data;

import java.util.Date;

/**
 * @author 李伟杰
 * @date 2023/2/11 14:44
 */
@Data
public class UserPartyAuthVo {

    /**
     * 角色编号
     */
    private String roleId;

    /**
     * 角色类型
     */
    private String roleType;

    /**
     * 参与者编号
     */
    private String partyId;

    /**
     * 参与者类型
     */
    private String partyType;

    /**
     * 创建用户
     */
    private String createUser;

    /**
     * 创建时间
     */
    private Date createTime;


    /**
     * 角色名称
     */
    private String roleName;

    /**
     * 角色代码
     */
    private String roleCode;

    /**
     * 角色名称集合
     */
    private String roleNameList;
}
