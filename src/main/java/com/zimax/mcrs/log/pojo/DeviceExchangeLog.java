package com.zimax.mcrs.log.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 设备交换日志
 * @author 林俊杰
 * @date 2022/11/30
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("log_log")
public class DeviceExchangeLog {

    /**
     * 日志主键
     */
    @TableId(type = IdType.AUTO)
    private int logId;

    /**
     * 日志类型
     */
    private String logType;

    /**
     * 日志状态
     */
    private String logStatus;

    /**
     * 设备主键
     */
    private int equipmentInt;

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * 操作类型
     */
    private String operationType;

    /**
     * 操作内容
     */
    private String operationContent;

    /**
     * 操作人
     */
    private String user;

    /**
     * 交互时间
     */
    private Date equipmentExchangeTime;

    /**
     * 创建时间
     */
    private Date createTime;


}
