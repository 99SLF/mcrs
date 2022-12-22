package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 终端
 * @author 林俊杰
 * @date 2022/11/30
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("eqi_device")
public class Device {

    /**
     * 终端主键
     */
    @TableId(type = IdType.AUTO)
    private int deviceId;

    /**
     * APPId
     */
    private String APPId;

    /**
     * 版本号
     */
    private String version;

    /**
     * 是否需要更新
     */
    private String needUpdate;

    /**
     * 终端软件类型
     */
    private String deviceSoftwareType;


    /**
     * 终端名称
     */
    private String  deviceName;

    /**
     * 设备主键
     */
    private int equipmentInt;

//    /**
//     * 接入点名称
//     */
//    private String assessName;

    /**
     * 工厂名称
     */
    private String factoryName;


//    /**
//     * 接入点种类
//     */
//    private String assessType;

//    /**
//     * 接入点Ip
//     */
//    private String assessIp;

//    /**
//     * 接入点资源号
//     */
//    private String equipmentId;

//    /**
//     * 接入点属性
//     */
//    private String assessAttributes;


//    /**
//     * 接入点安装位置
//     */
//    private String assessInstallLocation;

//    /**
//     * 接入方式
//     */
//    private String accessMethod;

    /**
     * 备注
     */
    private String remarks;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 创建角色
     */
    private String createRole;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 是否启用
     */
    private String enable;

    /**
     * 修改角色
     */
    private String updater;

    /**
     * 修改时间
     */
    private String updateTime;

    /**
     * 设备连接IP
     */
    private String equipmentIp;

    /**
     * 通讯协议
     */
    private String protocolCommunication;
}
