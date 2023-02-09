package com.zimax.mcrs.monitor.pojo.vo;

import lombok.Data;

/**
 * @author 李伟杰
 * @date 2023/1/3 16:16
 */
@Data
public class DeviceMonitorInfoVo {

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * 终端异常编号
     */

    private int deviceAbnId;

    /**
     * 软件运行状态编号
     */

    private int softwareRunId;


    /**
     * 设备接入状态编号
     */

    private int equipmentStatusId;

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
    private String deviceSoRunStatus;


    /**
     * 接入状态(正常异常)
     */
    private String accessStatus;


    /**
     * cup运行率
     */
    private String cpuRate;

    /**
     * 内存使用量
     */
    private String storageRate;

    /**
     * 误读率
     *
     */
    private String errorRate;


    /**
     * APPId
     */
    private String APPId;

    /**
     * 终端预警条数
     */
    private String deviceWarning;







}
