package com.zimax.components.coframe.rights.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import net.sf.jsqlparser.expression.DateTimeLiteralExpression;

import java.util.Date;
import java.util.List;

/**
 * @author 李伟杰
 * @date 2022/11/28
 */
@Data
public class User {

    /**
     * 操作员编号
     * 主键
     */
    @TableId(value = "operator_id",type = IdType.AUTO)
    private int operatorId;

    /**
     * 登录用户名
     */
    private int userId;

    /**
     * 登录密码
     */
    private String password;

    /**
     * 状态
     */
    private boolean status; // 状态 true可用 false禁用

    /**
     * 解锁时间
     */
    private Date unlockTime;

    /**
     * 最后一次登录时间
     */
    private Date lastLogin;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 角色集合
     */
    @TableField(exist = false) // 不是数据库的字段
    private List<Role> roles;

}
