package com.zimax.mcrs.warn.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.zimax.mcrs.device.pojo.WorkStation;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 预警规则监控对象
 * @author 林俊杰
 * @date 2023/1/7
 */
@Data
public class MonitorEquipmentVo {

    /**
     * 监控对象主键
     */
    @TableId(type = IdType.AUTO)
    private int monitorEquipmentId;

    /**
     * 预警规则主键
     */
    private int alarmRuleInt;

    /**
     * 监控对象主键（监控对象为设备，即为设备主键）
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
     * 设备安装位置
     */
    private String equipmentInstallLocation;

    /**
     *接入点名称
     */
    private String accPointResName;

    /**
     *基地代码
     */
    private String matrixCode;

    /**
     * 工厂代码
     */
    private String factoryCode;

    /**
     * 工厂名称
     */
    private String factoryName;

    /**
     * 工序名称
     */
    private String processName;

    /**
     *工位列表
     */
    @TableField(exist = false)
    String workStationList;
}
