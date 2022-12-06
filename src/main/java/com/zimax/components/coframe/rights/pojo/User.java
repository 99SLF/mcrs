package com.zimax.components.coframe.rights.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import net.sf.jsqlparser.expression.DateTimeLiteralExpression;

import java.math.BigDecimal;
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
    private BigDecimal operatorId;

    /**
     * 租户编号
     */

    private String tenantId;
    /**
     * 登录用户名
     */
    private String userId;

    /**
     * 密码
     */
    private String password;

    /**
     * 密码失效日期
     */
    private Date invalDate;

    /**
     * 用户名称
     */
    private String userName;

    /**
     * 本地密码认证
     * 本地密码认证、LDAP认证、等
     */
    private String authMode;

    /**
     * 状态
     * 正常，挂起，注销，锁定...
     */
    private String status;

    /**
     * 解锁的时间
     * 当状态为锁定时，解锁的时间
     */
    private Date unlockTime;

    /**
     * 菜单风格
     * 用户登录后菜单的风格
     */
    private String menuType;

    /**
     * 最后登录时间
     * 最后登录时间
     */
    private Date lastLogin;

    /**
     * 密码错误次数
     */
    private BigDecimal errCount;

    /**
     * 有效开始时间
     */
    private Date startDate;

    /**
     * 有效截止时间
     */
    private Date endDate;

    /**
     * 有效时间范围
     * 定义一个规则表达式，表示允许操作的有效时间范围
     */
    private String validTime;

    /**
     * 设置MAC
     * 允许设置多个MAC
     */
    private String macCode;

    /**
     * 设置IP地址
     * 允许设置多个IP地址
     */
    private String ipAddress;

    /**
     * 邮箱地址
     */
    private String email;

    /**
     * 创建人
     */
    private String createUser;

    /**
     * 创建时间
     */
    private Date createTime;




}


