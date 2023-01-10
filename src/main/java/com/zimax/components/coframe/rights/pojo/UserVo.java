package com.zimax.components.coframe.rights.pojo;

import lombok.Data;


/**
 * @author 李伟杰
 * @date 2023/1/9 23:45
 */
@Data
public class UserVo {

    /**
     * 操作员编号
     * 主键
     */

    private int operatorId;

    /**
     * 租户编号
     */

    private String tenantId;


    /**
     * 用户登录名(添加页面)
     */

    private String userId;

    /**
     * 用户名称(添加页面)
     */
    private String userName;

    /**
     * 登录密码(添加页面)
     */
    private String password;

    /**
     * 密码失效日期(添加页面)
     */

    private String invalDate;

    /**
     * 有效开始时间(添加页面)
     */

    private String startDate;


    /**
     * 有效截止时间(添加页面)
     */

    private String endDate;

    /**
     * 邮箱地址(添加页面)
     */
    private String email;

    /**
     * 用户状态(添加页面)
     * 正常，挂起，注销，锁定...
     */
    private String status;

    /**
     * 本地密码认证模式(添加页面)
     * 本地密码认证、LDAP认证、等
     */
    private String authMode;

    /**
     * 菜单布局(添加页面)
     * 用户登录后菜单的风格
     */
    private String menuType;

    /**
     * 设置IP地址(添加页面)
     * 允许设置多个IP地址
     */
    private String ipAddress;


    /**
     * 解锁的时间
     * 当状态为锁定时，解锁的时间
     */

    private String unlockTime;

    /**
     * 最后登录时间
     * 最后登录时间
     */

    private String lastLogin;

    /**
     * 密码错误次数
     */
    private int errCount;


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
     * 创建人
     */
    private String creator;

    /**
     * 创建时间
     */

    private String createTime;
}
