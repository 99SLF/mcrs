package com.zimax.mcrs.monitor.pojo.monDeviceStatus;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @author 李伟杰
 * @date 2023/2/21 11:30
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("mon_device_alarm")
public class MonitorDeviceAlarm {

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
    private Date occurrenceTime;

}
