package com.zimax.mcrs.monitor.pojo.monDeviceStatus;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @author 李伟杰
 * @date 2023/2/14 14:24
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("mon_device_real")
public class MonitorDeviceStatus {




    /**
     * appid(主键),非自增
     */
    private String appId;


//    /**
//     * 终端存在情况（0表示不存在，1表示存在）
//     */
//    private int deviceExists;

    /**
     * 接入类型(plc或rfid)   ACCESS_TYPE
     * 101
     * PLC
     *
     * 102
     * RFID
     *
     */
    /**
     * rfid接入状态(正常异常)硬件
     * EQUIPMENT_ACCESS_STATUS
     * 101
     * 正常
     *
     * 102
     * 异常
     *
     */
    private String plcStatus;
    private String rfidStatus;

    /**
     * 运行状态（软件）
     */
    private String deviceSoftwareStatus;


    /**
     * 天线状态（plc可以可以为空，rfid必填）
     *
     * ANTENNA_TYPE
     * 101
     * 正常
     *
     * 102
     * 异常
     *
     */
    private String antennaStatus;


    /**
     * 预警内容(字典)
     */
    private String warningContent;


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
     * 发生时间
     */
    @TableField(exist = false)
    private Date occurrenceTime;
    private Date softMonitorTime;
    private Date plcMonitorTime;
    private Date rfidMonitorTime;
    private Date antennaMonitorTime;
    private Date warnTime;
    /**
     * 预警等级
     */
    private String warnGrade;
    /**
     * 预警类型
     */
    private String warnType;
    /**
     * 设备资源号
     */
    @TableField(exist = false)
    private String resource;
    @TableField(exist = false)
    private String accessStatus;
    @TableField(exist = false)
    private String accessType;

}
