package com.zimax.mcrs.monitor.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 监测接入状态
 * @author 李伟杰
 * @date 2022/12/12 0:02
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("mon_access_status")
public class AccessStatus {

    /**
     * 监测终端类型接入状态编号
     */
    @TableId(type = IdType.AUTO)
    private int accessId;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * APPID
     */
    private String APPId;

    /**
     * 接入类型
     */
    private String accessType;

    /**
     * 接入状态
     */
    private String accessStatus;

    /**
     * 天线状态
     */
    private String antennaStatus;

    /**
     * 终端软件类型
     */
    private String deviceSoType;

    /**
     * 终端软件运行状态
     */
    private String deviceSoRuntime;

    /**
     * cup使用率
     */
    private String cpuRate;

    /**
     * 内存使用量
     */
    private String storageRate;

    /**
     * 发生时间
     *
     */
    private String occurTime;

    /**
     * 误读率
     *
     */
    private String errorRate;


    /**
     * 预警标题
     *
     */
    private String warningTitle;

    /**
     * 预警类型
     *
     */
    private String warningType;

    /**
     * 预警等级
     *
     */
    private String warningLevel;

    /**
     * 预警内容
     *
     */
    private String warningContent;

    /**
     * 备注
     *
     */
    private String remarks;
}
