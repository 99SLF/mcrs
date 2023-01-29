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
 * 接口日志
 *
 * @author 林俊杰
 * @date 2022/12/20
 */
@Data
public class InterfaceLogVo {

    /**
     * 来源
     */
    private String source;

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
     * 接口类型
     */
    private String interfaceType;

    /**
     * 设备接入Ip
     */
    private String equipmentIp;

    /**
     * 设备接入端口
     */
    private String equipmentContinuePort;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * JSON包
     */
    private String json;

    /**
     * 处理结果
     */
    private String result;

    /**
     * 开始时间
     */
    private String disposeStartTime;

    /**
     * 结束时间
     */
    private String disposeEndTime;

    /**
     * 调用者
     */
    private String invokerName;

    /**
     * 处理时长
     */
    private String disposeTime;

    /**
     * 接口名称
     */
    private String interfaceName;
}
