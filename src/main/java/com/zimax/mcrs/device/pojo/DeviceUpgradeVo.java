package com.zimax.mcrs.device.pojo;

import lombok.Data;

/**
 * 终端升级结果集映射
 * @author 林俊杰
 * @date 2022/12/14
 */
@Data
public class DeviceUpgradeVo {

    /**
     * 终端升级信息主键
     */
    private int deviceUpgradeId;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * 升级版本
     */
    private String upgradeVersion;

    /**
     * 更新包
     */
//    private int version;

    /**
     * 终端名称
     */
    private String deviceName;


    /**
     * 终端软件类型
     */
    private String deviceSoftwareType;

    /**
     * 工厂名称
     */
    private String factoryName;

    /**
     * 升级状态
     */
    private String upgradeStatus;

    /**
     * 版本更改人
     */
    private String versionUpdater;

    /**
     * 版本更改时间
     */
    private String versionUpdateTime;

}
