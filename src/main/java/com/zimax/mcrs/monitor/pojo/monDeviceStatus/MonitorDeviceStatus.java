package com.zimax.mcrs.monitor.pojo.monDeviceStatus;

import com.baomidou.mybatisplus.annotation.IdType;
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
     * 终端历史状态记录主键（不对外提供自增）
     */
    @TableId(type = IdType.AUTO)
    private int deviceRealId;

    /**
     * 终端名称
     */
    private String deviceName;


    /**
     * 终端存在情况（0表示不存在，1表示存在）
     */
    private int deviceExists;

    /**
     * 接入类型(plc或rfid)   ACCESS_TYPE
     * 101
     * PLC
     *
     * 102
     * RFID
     *
     */
    private String accessType;

    /**
     * 接入状态(正常异常)硬件
     * EQUIPMENT_ACCESS_STATUS
     * 101
     * 正常
     *
     * 102
     * 异常
     *
     */
    private String accessStatus;

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
    private Date occurrenceTime;

    /**
     * 备注
     */
    private String remarks;

    /**
     * 终端创建时间（服务端时间）,不对外提供
     *
     */
    private Date createTime;

    /**
     * 终端预警条数,不对外提供
     */
    private int deviceWarningNum;




}
