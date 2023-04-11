package com.zimax.mcrs.monitor.pojo.monDeviceStatus;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import net.sf.jsqlparser.expression.DateTimeLiteralExpression;

import java.util.Date;

/**
 * @author 李伟杰
 * @date 2023/2/14 14:23
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("mon_device_history")
/*废弃*/
public class MonitorDeviceHistory {




    /**
     * appid(主键),非自增
     */
    private String appId;

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
     * 预警内容
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







}
