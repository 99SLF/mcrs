package com.zimax.mcrs.monitor.pojo.vo;

import lombok.Data;

import java.util.Date;

/**
 * @author 李伟杰
 * @date 2023/2/9 14:17
 */
@Data
public class SoftwareRunStatusVo {


    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * 终端状态表主键
     */

    private int deviceRealId;

    /**
     * 设备主键
     */
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
     * APPID
     */
    private String APPId;

    /**
     * 终端名称
     */
    private String deviceName;

    /**
     * 终端软件类型
     */
    private String deviceSoftwareType;

    /**
     * 终端软件运行状态
     */
    private String deviceSoftwareStatus;

}
