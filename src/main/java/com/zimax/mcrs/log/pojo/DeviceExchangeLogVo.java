package com.zimax.mcrs.log.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 设备交换日志
 * @author 林俊杰
 * @date 2022/12/21
 */
@Data
public class DeviceExchangeLogVo {

    /**
     * 设备交换日志主键
     */
    @TableId(type = IdType.AUTO)
    private int deviceExchangeLogId;


    /**
     * 设备交换日志编号
     */
    private int deviceExchangeLogNum;

    /**
     * 日志类型
     */
    private String logType;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备连接IP
     */
    private String equipmentIp;

    /**
     * 设备连接端口
     */
    private String equipmentContinuePort;

    /**
     * APPId
     */
    private String APPId;

    /**
     * 工厂名称
     */
    private String factoryName;

    /**
     * 使用工序
     */
    private String processName;

    /**
     * 数据采集
     */
    private String dataAcquisition;

    /**
     * 操作人
     */
    private String operator;

    /**
     * 交互时间
     */
    private String exchangeTime;


}
