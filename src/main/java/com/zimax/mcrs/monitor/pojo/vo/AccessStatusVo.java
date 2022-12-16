package com.zimax.mcrs.monitor.pojo.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

/**
 * 监控表数据和非持久化属性终端告警条数，返回的非持久化结果集
 * @author 李伟杰
 * @date 2022/12/15 17:45
 */
@Data
public class AccessStatusVo {

//    /**
//     * 监测终端类型接入状态编号
//     */
//    private int accessId;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * APPID
     */
    private String APPId;

    /**
     * 终端软件类型
     */
    private String deviceSoType;

    /**
     * 终端软件运行状态
     */
    private String deviceSoRuntime;

    /**
     * 接入状态
     */
    private String accessStatus;

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
     * 终端告警
     *
     */
    private int deviceWarning;

}