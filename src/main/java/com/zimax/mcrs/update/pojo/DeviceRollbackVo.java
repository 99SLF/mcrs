package com.zimax.mcrs.update.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 设备回退信息
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeviceRollbackVo {
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
     * 版本回退时间
     */
    private String versionRollbackTime;

    /**
     * 设备回退主键
     */
    private int deviceRollbackId;

    /**
     * 终端程序安装路径
     */
    private String programInstallationPath;

    /**
     * 终端执行程序安装路径
     */
    private String executorInstallationPath;
}
