package com.zimax.mcrs.monitor.pojo.vo;

import lombok.Data;


/**
 * @author 李伟杰
 * @date 2023/4/11 11:48
 */
@Data
public class MonitorDeviceAlarmVo {

    /**
     * 预警记录表主键
     */
    private int deviceAlarmId;

    /**
     * appid
     */
    private String appId;

    /**
     * 告警内容
     */
    private String warningContent;

    /**
     * 接入状态
     */
    private String accessStatus;

    /**
     * 软件运行状态
     */
    private String deviceSoftwareStatus;

    /**
     * 天线状态
     */
    private String antennaStatus;
    /**
     * 预警等级
     */
    private String warnGrade;
    /**
     * 预警类型
     */
    private String warnType;
    /**
     * 预警来源  RFID/PLC
     */
    private String accessType;
    /**
     * 发生时间
     */
    private String occurrenceTime;

    /**
     * 终端主键
     */
    private int deviceId;

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

}


