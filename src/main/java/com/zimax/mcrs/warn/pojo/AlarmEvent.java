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
@TableName("alarmEvent")
public class AlarmEvent {

    /**
     * 告警事件编码
     */
    @TableId(type = IdType.AUTO)
    private int alarmEventId;

    /**
     * 告警事件标题
     */
    private String alarmEventTitle;

    /**
     * 启用状态
     */
    private String enableStatus;

    /**
     * 告警级别
     */
    private String alarmLevel;

    /**
     * 告警分类
     */
    private String alarmCategory;

    /**
     * 告警类型
     */
    private String alarmType;

    /**
     * 制单人
     */
    private String makeFormPeople;

    /**
     * 制单时间
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date makeFormTime;


    /**
     * 修改人
     */
    private String updatePeople;

    /**
     * 修改时间
     */
    private Date updateTime;

}
