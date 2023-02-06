package com.zimax.mcrs.device.pojo;

import lombok.Data;

/**
 * 终端升级结果集映射
 *
 * @author 李伟杰
 * @date 2022/12/14
 */
@Data
public class DeviceRollbackVo {

    /**
     * 终端回退信息主键
     */
    private int deviceRollbackId;

    /**
     * 设备主键
     */
    private int equipmentInt;

    /**
     * 设备信息数据的主键
     */
    private int equipTypeId;

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * 更新包管理主键
     */
    private int uploadId;

    /**
     * 接入点资源维护数据的主键
     */
    private Integer accPointResId;

    /**
     * 工序信息数据的主键
     */
    private int processId;

    /**
     * 工厂信息数据的主键
     */
    private int factoryId;

    /**
     * 操作员编号
     * 主键
     */
    private int operatorId;

    /**
     * APPId
     */
    private String APPId;

    /**
     * 终端名称
     */
    private String deviceName;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * 终端软件类型
     */
    private String deviceSoftwareType;


    /**
     * 更新包单号
     */
    private String uploadNumber;

    /**
     * 设备类型名称
     */
    private String equipTypeName;

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
     * 接入点名称
     */
    private String accPointResName;


    /**
     * 升级状态
     */
    private String upgradeStatus;

    /**
     * 版本回退人
     */
    private String versionRollbackPeople;

    /**
     * 版本更改人
     */
    private String createName;

    /**
     * 版本回退时间
     */
    private String versionRollbackTime;

}
