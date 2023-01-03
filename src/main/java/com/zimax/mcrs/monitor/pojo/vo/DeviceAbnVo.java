package com.zimax.mcrs.monitor.pojo.vo;

import lombok.Data;


/**
 * 监控表数据和非持久化属性终端告警条数，返回的非持久化结果集
 * @author 李伟杰
 * @date 2022/12/15 17:45
 */
@Data
public class DeviceAbnVo {

    /**
     * 终端异常编号
     */
    private int deviceAbnId;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * APPID
     */
    private String APPId;

    /**
     * 终端名称
     */
    private String deviceName;

    /**
     * 使用工序
     */
    private String useProcess;

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
     * 发生时间
     *
     */
    private String occurTime;


    /**
     * 备注
     *
     */
    private String remarks;

    /**
     * 创建时间
     *
     */
    private String createTime;
}
