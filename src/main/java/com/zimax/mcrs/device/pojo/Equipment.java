package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 设备
 *
 * @author 林俊杰
 * @date 2022/11/28
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("eqi_equipment")
public class Equipment {

    /**
     * 设备主键
     */
    @TableId(type = IdType.AUTO)
    private int equipmentInt;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * 是否启用状态
     */
    private String enabledState;

    /**
     * 设备属性
     */
    private String equipmentProperties;

    /**
     * MES连接IP
     */
    private String mesContinueIp;

    /**
     * 设备安装位置
     */
    private String equipmentInstallLocation;

    /**
     * 设备连接端口
     */
    private String equipmentContinuePort;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 备注
     */
    private String remarks;

    /**
     * 设备连接IP
     */
    private String equipmentIp;

    /**
     * 通讯协议
     */
    private String protocolCommunication;
}
