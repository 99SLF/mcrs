package com.zimax.mcrs.monitor.pojo.vo;

import lombok.Data;

import java.util.Date;

/**
 * @author 李伟杰
 * @date 2023/1/3 16:16
 */
@Data
public class DeviceMonitorInfoVo {

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * 终端状态表主键
     */

    private int deviceRealId;

    /**
     * 设备主键
     */
    private int equipmentInt;

    /**
     * 终端名称
     */
    private String deviceName;


    /**
     * 终端软件类型，字典
     */
    private String deviceSoftwareType;


    /**
     * APPId
     */
    private String APPId;


    /**
     * 设备资源号
     */
    private String equipmentId;


    /**
     * 设备名称
     */

    private String equipmentName;


    /**
     * 接入状态(正常异常)，字典
     */
    private String accessStatus;


    /**
     * 运行状态（软件）
     */
    private String deviceSoftwareStatus;


    /**
     * 终端预警条数,不对外提供
     */
    private int deviceWarningNum;

    /**
     * cup使用率
     */
    private String cpuRate;

    /**
     * 内存使用率
     */
    private String storageRate;

    /**
     * 误读率
     *
     */
    private String errorRate;
    /**
     * 终端状态
     *
     */
    private String deviceStatus;
    /**
     * plc接入状态
     *
     */
    private String plcStatus;
    private String rfidStatus;
    private Date softMonitorTime;
    private String equipmentIp;

}
