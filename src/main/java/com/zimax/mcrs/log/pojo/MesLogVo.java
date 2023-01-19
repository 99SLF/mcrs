package com.zimax.mcrs.log.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
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
public class MesLogVo {

    /**
     * 日志类型
     */
    private String logStatus;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备名称
     */
    private String equipmentName;

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
    private String mesContent;

    /**
     * 创建人
     */
    @TableField(exist = false)
    private String createName;

    /**
     * 创建时间
     */
    private String createTime;

}
