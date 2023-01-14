package com.zimax.mcrs.log.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 接口日志
 *
 * @author 林俊杰
 * @date 2022/12/20
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("log_interface_log")
public class InterfaceLogVo {

    /**
     * 接口日志Id
     */
    @TableId(type = IdType.AUTO)
    private int interfaceLogId;

    /**
     * 接口日志编号
     */
    private String interfaceLogNum;

    /**
     * 日志类型
     */
    private String logType;

    /**
     * 来源
     */
    private String source;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * APPID
     */
    private String APPId;

    /**
     * 设备接入IP
     */
    private String equipmentIp;

    /**
     * 设备接入端口
     */
    private String equipmentContinuePort;

    /**
     * 接口名称
     */
    private String interfaceName;

    /**
     *创建时间
     */
    private String createTime;

    /**
     * JSON包
     */
    private String JSONPage;

    /**
     * 处理结果
     */
    private String disposeResult;

    /**
     * 开始时间
     */
    private String startTime;

    /**
     * 结束时间
     */
    private String endTime;

    /**
     * 调用者
     */
    private String invoker;

    /**
     * 处理时长
     */
    private String disposeTime;

    /**
     * 接口类型
     */
    private String interfaceType;
}
