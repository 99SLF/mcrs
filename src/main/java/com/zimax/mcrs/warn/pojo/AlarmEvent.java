package com.zimax.mcrs.warn.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 告警事件
 * @author 林俊杰
 * @date 2022/11/29
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("war_alarm_event")
public class AlarmEvent {

    /**
     * 预警事件主键
     */
    @TableId(type = IdType.AUTO)
    private Integer alarmEventInt;

    /**
     * 预警事件编码
     */
    private String alarmEventId;

    /**
     * 预警事件标题
     */
    private String alarmEventTitle;

    /**
     * 预警信息内容
     */
    private String alarmEventContent;

    /**
     * 是否启用
     */
    private String enableStatus;

    /**
     * 预警级别
     */
    private String alarmLevel;

    /**
     * 预警类型
     */
    private String alarmType;

    /**
    * 上限
    */
    private String upperLimit;

    /**
     * 下限
     */
    private String lowerLimit;

    /**
     * 制单人
     */
    private String makeFormPeople;

    /**
     * 制单时间
     */
    private String makeFormTime;


    /**
     * 修改人
     */
    private String updatePeople;

    /**
     * 修改时间
     */
    private String updateTime;

}
