package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 终端
 * @author 林俊杰
 * @date 2022/11/30
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("cap_Device")
public class Device {

    /**
     * APPId
     */
    @TableId(type = IdType.AUTO)
    private String APPId;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 终端类型
     */
    private String deviceType;

    /**
     * 终端名称
     */
    private int deviceName;

    /**
     * 接入方式
     */
    private String assessMethod;

    /**
     * 接入端名称
     */
    private String assessName;

    /**
     * 接入端资源号
     */
    private String assessResourceId;

    /**
     * 接入端属性
     */
    private String assessAttributes;

    /**
     * 接入端Ip
     */
    private String assessIp;

    /**
     * 接入端安装位置
     */
    private String assessInstallLocation;

    /**
     * 终端软件类型
     */
    private String deviceSoftwareType;

    /**
     * 使用工序
     */
    private String useProcess;

    /**
     * 注册人员
     */
    private String registrant;

    /**
     * 注册人员
     */
    private String registerRole;

    /**
     * 注册时间
     */
    private Date registrationDate;

    /**
     * 是否启用
     */
    private String enable;

    /**
     * 终端状态
     */
    private String deviceStatus;
}
