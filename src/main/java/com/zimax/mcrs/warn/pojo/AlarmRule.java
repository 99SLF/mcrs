package com.zimax.mcrs.warn.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

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
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @TableField(fill = FieldFill.INSERT_UPDATE)
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
