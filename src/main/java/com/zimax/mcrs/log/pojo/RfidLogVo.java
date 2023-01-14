package com.zimax.mcrs.log.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * RFID交互日志
 *
 * @author 林俊杰
 * @date 2023/1/13
 */
@Data
public class RfidLogVo {

    /**
     * RFID交换日志Id
     */
    @TableId(type = IdType.AUTO)
    private int rfidLogId;

    /**
     * RFID交换日志编号
     */
    private String rfidLogNum;

    /**
     * 日志类型
     */
    private String logType;

    /**
     * 设备主键
     */
    private int equipmentInt;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * APPID
     */
    private String APPId;

    /**
     * 终端名称
     */
    private String deviceName;

    /**
     * RFID-ID
     */
    private String rfidId;

    /**
     * 设备连接IP
     */
    private String equipmentIp;

    /**
     * 设备连接端口
     */
    private String equipmentContinuePort;

    /**
     *参数名称
     */
    private String parameterName;

    /**
     * 参数值
     */
    private String parameterNum;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 创建时间
     */
    private String createTime;

}
