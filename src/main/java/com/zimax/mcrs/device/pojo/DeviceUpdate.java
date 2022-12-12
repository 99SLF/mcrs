package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 终端更新
 *
 * @author 林俊杰
 * @date 2022/12/1
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("eqi_device_update")
public class DeviceUpdate {

    /**
     * 设备资源号
     */
    @TableId(type = IdType.AUTO)
    private String equipmentId;


    /**
     * 版本号
     */
    private String version;

    /**
     * 资源包单号
     */
    private String resourceNumber;

    /**
     * 终端软件类型
     */
    private String deviceSoftwareType;

    /**
     * 操作类型
     */
    private String operateType;

    /**
     * 接入点名称
     */
    private String assessName;

    /**
     * 设备类型
     */
    private String equipmentType;

    /**
     * 工厂名称
     */
    private String factoryName;

    /**
     * 版本更改人
     */
    private String versionChange;

    /**
     * 版本更改时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String versionChangeTime;


}
