package com.zimax.mcrs.monitor.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @author 李伟杰
 * @date 2023/1/3 10:29
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("mon_soft_status")
public class SoftwareRunStatus {

    /**
     * 软件运行状态编号
     */
    @TableId(type = IdType.AUTO)
    private int softwareRunId;

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
