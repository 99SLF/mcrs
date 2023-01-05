package com.zimax.mcrs.log.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 异常日志
 *
 * @author 林俊杰
 * @date 2023/1/4
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("log_abn_log")
public class AbnLog {

    /**
     * 异常日志Id
     */
    @TableId(type = IdType.AUTO)
    private int abnLogId;

    /**
     * 异常日志编号
     */
    private String abnLogNum;

    /**
     * 日志类型
     */
    private String logType;

    /**
     * 设备主键
     */
    private int equipmentInt;

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * 预警标题
     */
    private String abnTitle;

    /**
     * 预警类型
     */
    private String abnType;

    /**
     * 预警等级
     */
    private String abnLevel;

    /**
     * 预警内容
     */
    private String abnContent;

    /**
     *交互时间
     */
    private Date exchangeTime;


}
