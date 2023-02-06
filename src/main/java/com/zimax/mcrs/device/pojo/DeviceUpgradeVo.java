package com.zimax.mcrs.device.pojo;
import lombok.Data;

/**
 * 终端升级结果集映射（终端升级记录）
 *
 * @author 李伟杰
 * @date 2022/12/14
 */
@Data
public class DeviceUpgradeVo {

    /**
     * 终端升级信息主键
     */
    private int deviceUpgradeId;

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
     * 终端软件类型
     */
    private String deviceSoftwareType;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * 设备类型名称
     */
    private String equipTypeName;

    /**
     * 更新包单号
     */
    private String uploadNumber;

    /**
     * 升级版本号
     */
    private String version;

    /**
     * 升级前的版本
     */
    private String upgradeBeforeVersion;


    /**
     * 升级状态
     */
    private String upgradeStatus;

    /**
     * 接入点名称
     */
    private String accPointResName;


    /**
     * 工厂名称
     */
    private String factoryName;

    /**
     * 版本更改人
     */
    private String createName;

    /**
     * 版本更改时间
     */
    private String versionUpdateTime;

}
