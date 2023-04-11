package com.zimax.mcrs.monitor.pojo.vo;

import java.util.Date;


/**
 * @author 李伟杰
 * @date 2023/4/11 11:48
 */
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
     * APPId
     */
    private String APPId;

    /**
     * 版本号
     */
    private String version;

    /**
     * 是否启用
     */
    private String enable;

    /**
     * 注册状态
     */
    private String registerStatus;

    /**
     * 终端软件类型
     */
    private String deviceSoftwareType;

    /**
     * 终端名称
     */
    private String  deviceName;

    /**
     * 设备主键
     */
    private int equipmentInt;

    /**
     * 接入方式
     */
    private String accessMethod;

    /**
     * 备注
     */
    private String remarks;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 终端程序安装路径
     */
    private String programInstallationPath;

    /**
     * 终端执行程序安装路径
     */
    private String executorInstallationPath;

    /**
     * 是否版本初始化
     */

    private String isUpdate;



    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * 设备安装位置
     */
    private String equipmentInstallLocation;

    /**
     * 设备信息主键
     */
    private Integer equipTypeId;

    /**
     * 设备连接端口
     */
    private String equipmentContinuePort;

    /**
     * 设备连接IP
     */
    private String equipmentIp;

    /**
     * 接入点资源维护数据的主键
     */
    private Integer accPointResId;

}


