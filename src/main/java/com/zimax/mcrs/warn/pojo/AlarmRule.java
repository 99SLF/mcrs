package com.zimax.mcrs.warn.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 告警规则
 * @author 林俊杰
 * @date 2022/11/29
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("alarmRule")
public class AlarmRule {

    /**
     * 告警规则编码
     */
    @TableId(type = IdType.AUTO)
    private int alarmRuleId;

    /**
     * 告警规则标题
     */
    private String alarmRuleTitle;

    /**
     * 监控规则状态
     */
    private String alarmRuleStatus;

    /**
     * 监控层级
     */
    private String monitorLevel;

    /**
     * 告警事件编码
     */
    private int alarmEventId;

    /**
     * 监控对象
     */
    private String monitorObject;

    /**
     * 告警规则描述
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

}
