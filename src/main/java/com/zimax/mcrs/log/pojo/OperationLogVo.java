package com.zimax.mcrs.log.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 操作日志
 * @author 林俊杰
 * @date 2022/12/21
 */
@Data
public class OperationLogVo {

    /**
     * 日志状态
     */
    private String logStatus;

    /**
     * 操作类型
     */
    private String operationType;

    /**
     * 操作内容
     */
    private String operationContent;

    /**
     * 操作结果
     */
    private String result;

    /**
     * 操作人
     */
    @TableField(exist = false)
    private String operateName;

    /**
     * 操作时间
     */
    private String operationTime;



}
