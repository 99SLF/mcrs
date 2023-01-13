package com.zimax.mcrs.update.pojo;

import lombok.Data;

/**
 * 设备管理升级信息
 */
@Data
public class DeviceUpgradeVo {
    /**
     * 设备APPID
     */
    private String appId;

    /**
     * 终端ID
     */
    private Integer deviceId;

    /**
     * 更新包主键
     */
    private int uploadId;

    /**
     * 更新包版本
     */
    private String version;

    /**
     * 更新策略
     */
    private String uploadStrategy;

    /**
     * 升级状态
     */
    private String upgradeStatus;

    /**
     * 版本更新时间
     */
    private String versionUpdateTime;

    /**
     * 设备升级主键
     */
    private int deviceUpgradeId;

    /**
     * 终端程序安装路径
     */
    private String programInstallationPath;

    /**
     * 终端执行程序安装路径
     */
    private String executorInstallationPath;


}
