package com.zimax.mcrs.framework.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 角色
 * @author 施林丰
 * @date 2022/12/2
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("app_application")
public class Application {

    /**
     * 应用编号
     */
    @TableId(type = IdType.AUTO)
    private int appId;

    /**
     * 应用代码
     */
    private String appCode;

    /**
     * 应用名称
     */
    private String appName;

    /**
     * 应用类型
     */
    private String appType;

    /**
     * 显示顺序
     */
    private int displayOrder;

    /**
     * 是否开通
     */
    private char isOpen;

    /**
     * 开通日期
     */
    private Date openDate;

    /**
     * 协议类型
     */
    private String protocolType;

    /**
     * 应用IP
     */
    private String ipAddr;

    /**
     * 应用端口
     */
    private String ipPort;

    /**
     * 应用链接
     */
    private String url;

    /**
     * 应用描述
     */
    private String appDesc;

    /**
     * 应用信息
     */
    private String appInfo;

    /**
     * 租户信息
     */
    private String tenantId;

}
