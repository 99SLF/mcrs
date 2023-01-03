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
 * @date 2023/1/3 10:42
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("mon_device_abn")
public class DeviceAbn {

    /**
     * 终端异常编号
     */
    @TableId(type = IdType.AUTO)
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
    private Date occurTime;


    /**
     * 备注
     *
     */
    private String remarks;

    /**
     * 创建时间
     *
     */
    private Date createTime;
}
