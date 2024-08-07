package com.zimax.mcrs.warn.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.zimax.mcrs.device.pojo.RfidPoint;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

/**
 * 预警规则
 * @author 林俊杰
 * @date 2022/11/29
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("war_alarm_rule")
public class AlarmRule {

    /**
     * 预警规则主键
     */
    @TableId(type = IdType.AUTO)
    private int alarmRuleInt;


    /**
     * 预警规则编码
     */
    private String alarmRuleId;


    /**
     * 预警规则标题
     */
    private String alarmRuleTitle;

    /**
     * 是否启用
     */
    private String enable;

    /**
     * 监控层级
     */
    private String monitorLevel;

    /**
     * 预警事件编码
     */
    private int alarmEventInt;

    /**
     * 预警规则描述
     */
    private String alarmRuleDescribe;

    /**
     * 制单人
     */
    private String ruleMakeFormPeople;

    /**
     * 制单时间
     */
    private Date ruleMakeFormTime;


    /**
     * 修改人
     */
    private String ruleUpdatePeople;

    /**
     * 修改时间
     */
    private Date ruleUpdateTime;

    /**
     *监控对象列表
     */
    @TableField(exist = false)
    List<MonitorEquipmentVo> monitorEquipmentVoList;

    /**
     *监控对象列表
     */
    @TableField(exist = false)
    List<MonitorEquipment> monitorEquipmentList;

}
