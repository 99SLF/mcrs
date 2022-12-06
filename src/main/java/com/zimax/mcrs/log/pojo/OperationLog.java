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
@TableName("cap_operation_log")
public class OperationLog {

    /**
     * 操作日志Id
     */
    @TableId(type = IdType.AUTO)
    private int operationLogId;

    /**
     * 操作时间
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date operationTime;

    /**
     * 操作类型
     */
    private String operationType;

    /**
     * 操作内容
     */
    private String operationContent;

    /**
     * 操作对象
     */
    private String operationObject;

    /**
     * 操作人
     */
    private String operator;

    /**
     * 操作角色
     */
    private String operationRole;

    /**
     * 操作结果
     */
    private String operationResult;

}
