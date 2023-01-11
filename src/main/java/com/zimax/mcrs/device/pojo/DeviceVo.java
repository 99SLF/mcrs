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
     * 是否启用
     */
    private String enable;

    /**
     * 注册状态
     */
    private String registerStatus;

    /**
     * 终端软件类型
     */
    private String deviceSoftwareType;

    /**
     * 终端名称
     */
    private String  deviceName;

    /**
     * 接入点资源维护数据的主键
     */
    private int accPointResId;

    /**
     *接入点名称
     */
    private String accPointResName;

    /**
     * 工厂名称
     */
    private String factoryName;

    /**
     * 设备主键
     */
    private int equipmentInt;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备连接IP
     */
    private String equipmentIp;

    /**
     * 设备连接端口
     */
    private String equipmentContinuePort;

    /**
     * 工序名称
     */
    private String processName;

    /**
     * 设备安装位置
     */
    private String equipmentInstallLocation;

    /**
     * 接入方式
     */
    private String accessMethod;

    /**
     * 备注
     */
    private String remarks;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     *设备类型名称
     */
    private String equipTypeName;

    /**
     * 支持通信协议
     */
    private String protocolCommunication;

    /**
     * 终端程序安装路径
     */
    private String programInstallationPath;

    /**
     * 终端执行程序安装路径
     */
    private String executorInstallationPath;


}
