package com.zimax.mcrs.log.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


/**
 * MES交互日志
 *
 * @author 林俊杰
 * @date 2023/1/13
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("log_mes_log")
public class MesLogVo {

    /**
     * MES交换日志Id
     */
    @TableId(type = IdType.AUTO)
    private int mesLogId;

    /**
     * MES交换日志编号
     */
    private String mesLogNum;

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
     *MES连接IP地址
     */
    private String mesIpAddress;

    /**
     * 设备连接端口
     */
    private String equipmentContinuePort;

    /**
     * 交互内容
     */
    private String content;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 创建时间
     */
    private String createTime;

}
