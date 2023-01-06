package com.zimax.mcrs.update.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 设备终端注册信息
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeviceEquipmentVo {

    /**
     * IP
     */
    private String equipmentIp;

    /**
     * 端口
     */
    private String equipmentContinuePort;

    /**
     * 终端主键
     */
    private Integer equipmentInt;

    /**
     * 注册状态
     */
    private String registerStatus;

    /**
     * 设备主键
     */
    private Integer deviceId;

    /**
     * APPID
     */
    private String appId;

}
