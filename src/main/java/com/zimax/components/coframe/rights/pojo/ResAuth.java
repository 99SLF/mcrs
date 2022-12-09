package com.zimax.components.coframe.rights.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 资源授权
 *
 * @author 苏尚文
 * @date 2022/12/9 9:55
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("cap_res_auth")
public class ResAuth {

    /**
     * 参与者编号
     */
    private String partyId;

    /**
     * 参与者类型
     */
    private String partyType;

    /**
     * 资源编号
     */
    private String resId;

    /**
     * 资源类型
     */
    private String resType;

    /**
     * 资源状态
     */
    private String resState;

    /**
     * 参与者范围
     */
    private String partyScope;

    /**
     * 创建用户
     */
    private String createUser;

    /**
     * 创建时间
     */
    private Date createTime;

}
