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
 * @date 2022/11/30
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("cap_device_exchange_log")
public class DeviceExchangeLog {

    /**
     * 设备交换日志编号
     */
    @TableId(type = IdType.AUTO)
    private int deviceExchangeLogId;
    /**
     * 设备编号
     */
    private int deviceId;

    /**
     * 用户名称
     */
    private String userName;

    /**
     * 交互内容
     */
    private String exchangeContent;

    /**
     * 交互时间
     */
    private Date exchangeTime;

    /**
     * 创建时间
     */
    private Date createTime;

}
