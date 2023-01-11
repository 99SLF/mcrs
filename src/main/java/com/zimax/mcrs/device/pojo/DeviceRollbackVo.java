package com.zimax.mcrs.device.pojo;

import lombok.Data;

/**
 * 终端升级结果集映射
 * @author 林俊杰
 * @date 2022/12/14
 */
@Data
public class DeviceRollbackVo {

    /**
     * 终端回退信息主键
     */
    private int deviceRollbackId;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * APPId
     */
    private String APPId;


    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * 更新包单号
     */
    private String uploadNumber;

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
     * 回退前版本
     */
    private String rollbackBeforeVersion;

    /**
     * 回退版本
     */
    private String version;

    /**
     * 升级状态
     */
    private String upgradeStatus;

    /**
     * 版本回退人
     */
    private String versionRollbackPeople;

    /**
     * 版本回退时间
     */
    private String versionRollbackTime;

}
