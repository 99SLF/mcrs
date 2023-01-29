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
 * 设备交换日志
 * @author 林俊杰
 * @date 2022/12/21
 */
@Data
public class DeviceExchangeLogVo {

    /**
     * 日志状态
     */
    private String logStatus;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * APPId
     */
    private String APPId;

    /**
     * 设备连接IP
     */
    private String equipmentIp;

    /**
     * 设备连接端口
     */
    private String equipmentContinuePort;

    /**
     * 基地名称
     */
    private String matrixName;

    /**
     * 工厂名称
     */
    private String factoryName;

    /**
     * 使用工序
     */
    private String processName;

    /**
     * 操作类型
     */
    private String operationType;

    /**
     * 操作内容
     */
    private String operationContent;

    /**
     * 操作人
     */
    @TableField(exist = false)
    private String operateName;

    /**
     * 交互时间
     */
    private String equipmentExchangeTime;


}
