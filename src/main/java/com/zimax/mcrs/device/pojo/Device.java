package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.HashMap;

/**
 * 终端
 * @author 林俊杰
 * @date 2022/11/30
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("eqi_device")
public class Device{

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
     * 设备主键
     */
    private int equipmentInt;

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
    private Date createTime;

    /**
     * 终端程序安装路径
     */
    private String programInstallationPath;

    /**
     * 终端执行程序安装路径
     */
    private String executorInstallationPath;

}
