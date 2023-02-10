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
     * 软件运行状态编号
     */
    private int softwareRunId;

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
    private String deviceSoType;

    /**
     * 终端软件运行状态
     */
    private String deviceSoRunStatus;

    /**
     * cup使用率
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
     * 创建时间
     *
     */
    private Date createTime;
}
