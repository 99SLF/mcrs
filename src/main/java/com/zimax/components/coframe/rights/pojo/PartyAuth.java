package com.zimax.components.coframe.rights.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 参与者授权
 *
 * @author 苏尚文
 * @date 2022/12/9 11:30
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("cap_party_auth")
public class PartyAuth {

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

}
