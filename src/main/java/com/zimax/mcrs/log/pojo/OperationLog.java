package com.zimax.mcrs.log.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 操作日志
 * @author 林俊杰
 * @date 2022/12/2
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("log_operation_log")
public class OperationLog {

    /**
     * 操作日志Id
     */
    @TableId(type = IdType.AUTO)
    private int operationLogId;

    /**
     * 操作日志编号
     */
    private String operationLogNum;

    /**
     * 日志类型
     */
    private String logType;

    /**
     * 日志状态
     */
    private String logStatus;

    /**
     * 操作内容
     */
    private String operationContent;

    /**
     * 操作结果
     */
    private String operationResult;

    /**
     * 操作人
     */
    private String operator;

    /**
     * 操作时间
     */
    private Date operationTime;



}
