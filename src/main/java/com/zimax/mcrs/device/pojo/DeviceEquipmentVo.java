package com.zimax.mcrs.device.pojo;

import lombok.Data;

/**
 * @author 李伟杰
 * @date 2023/1/5 15:06
 */
@Data
public class DeviceEquipmentVo {

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * APPId
     */
    private String APPId;

    /**
     * 版本号
     */
    private String version;

    /**
     * 是否需要更新
     */
    private String needUpdate;

    /**
     * 终端软件类型
     */
    private String deviceSoftwareType;


    /**
     * 终端名称
     */
    private String deviceName;

    /**
     * 设备主键
     */
    private int equipmentInt;


    /**
     * 工厂名称
     */
    private String factoryName;

    /**
     * 备注
     */
    private String remarks;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 创建角色
     */
    private String createRole;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 是否启用
     */
    private String enable;

    /**
     * 修改角色
     */
    private String updater;

    /**
     * 修改时间
     */
    private String updateTime;

    /**
     * 设备连接IP
     */
    private String equipmentIp;

    /**
     * 通讯协议
     */
    private String protocolCommunication;


    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * 是否启用状态
     */
    private String enabledState;

    /**
     * 设备属性
     */
    private String equipmentProperties;

    /**
     * MES连接IP
     */
    private String mesContinueIp;

    /**
     * 设备安装位置
     */
    private String equipmentInstallLocation;

    /**
     * 设备连接端口
     */
    private String equipmentContinuePort;


}
