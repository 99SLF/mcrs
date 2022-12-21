package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 终端映射层
 * @author 林俊杰
 * @date 2022/12/16
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeviceVo {

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

    /**
     * 接入点名称
     */
    private String equipmentName;

    /**
     * 工厂名称
     */
    private String factoryName;


    /**
     * 接入点种类
     */
    private String assessType;

    /**
     * 接入点Ip
     */
    private String mesContinueIp;

    /**
     * 接入点资源号
     */
    private String equipmentId;

    /**
     * 接入点属性
     */
    private String equipmentProperties;


    /**
     * 接入点安装位置
     */
    private String equipmentInstallLocation;

    /**
     * 接入方式
     */
    private String equipmentContinuePort;

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


}