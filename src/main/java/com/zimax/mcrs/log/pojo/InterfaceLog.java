package com.zimax.mcrs.log.pojo;


import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 接口日志
 * @author 林俊杰
 * @date 2022/12/2
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("cap_interface_log")
public class InterfaceLog {

    /**
     * 接口日志Id
     */
    @TableId(type = IdType.AUTO)
    private int interfaceLogId;

    /**
     * 操作时间
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date operationTime;

    /**
     * 接口名称
     */
    private String interfaceName;

    /**
     * 接口状态
     */
    private String interfaceLogStatus;

    /**
     * 操作人
     */
    private String operator;

    /**
     * 操作角色
     */
    private String operationRole;


}
