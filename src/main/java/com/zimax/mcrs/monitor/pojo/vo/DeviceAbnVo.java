package com.zimax.mcrs.monitor.pojo.vo;

import lombok.Data;


/**
 * 监控表数据和非持久化属性终端告警条数，返回的非持久化结果集
 * @author 李伟杰
 * @date 2022/12/15 17:45
 */
@Data
public class DeviceAbnVo {



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
     * 预警事件主键
     */
    private int alarmEventInt;

    /**
     * 预警事件编码
     */
    private String alarmEventId;

    /**
     * 接入点主键
     */
    private int accPointResId;

    /**
     * 工序主键
     */
    private int processId;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备名称
     */

    private String equipmentName;

    /**
     * APPID
     */
    private String APPId;

    /**
     * 终端名称
     */
    private String deviceName;


    /**
     * 使用工序
     */
    private String processName;

    /**
     * 预警标题
     *
     */
    private String alarmEventTitle;

    /**
     * 预警类型
     *
     */
    private String warnType;

    /**
     * 预警等级
     *
     */
    private String warnGrade;

    /**
     * 预警内容
     *
     */
    private String warningContent;

    /**
     * 发生时间
     *
     */
    private String occurrenceTime;


    /**
     * 备注
     *
     */
    private String remarks;


}
