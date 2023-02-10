package com.zimax.mcrs.log.pojo;


import com.baomidou.mybatisplus.annotation.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 接口日志
 *
 * @author 林俊杰
 * @date 2022/12/20
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("log_log")
public class InterfaceLog {

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
     * 设备主键
     */
    private int equipmentInt;

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * 来源
     */
    private String source;

    /**
     * 接口类型
     */
    private String interfaceType;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * JSON包
     */
    private String json;

    /**
     * 处理结果
     */
    private String result;

    /**
     * 开始时间
     */
    private Date disposeStartTime;

    /**
     * 结束时间
     */
    private Date disposeEndTime;

    /**
     * 调用者
     */
    private String user;

    /**
     * 处理时长
     */
    private String disposeTime;

    /**
     * 接口名称
     */
    private String interfaceName;
}
