package com.zimax.mcrs.warn.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
public class AlarmRuleVo {

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
    private Integer alarmEventId;

    /**
     * 预警事件主键
     */
    private Integer alarmEventInt;

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
    private String ruleMakeFormTime;


    /**
     * 修改人
     */
    private String ruleUpdatePeople;

    /**
     * 修改时间
     */
    private String ruleUpdateTime;

    /**
     *监控对象列表
     */
    @TableField(exist = false)
    List<MonitorEquipmentVo> monitorEquipmentVoList;

}
