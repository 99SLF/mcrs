package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 终端
 * @author 林俊杰
 * @date 2022/11/30
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("cap_Device")
public class Device {

    /**
     * APPId
     */
    @TableId(type = IdType.AUTO)
    private int APPId;

    /**
     * 设备资源号
     */
    private int equipmentId;

    /**
     * 接入方式
     */
    private String assessMethod;

    /**
     * 终端软件类型
     */
    private String deviceType;

    /**
     * 使用工序
     */
    private String useProcess;

    /**
     * 注册人员
     */
    private String registrant;

    /**
     * 注册人员
     */
    private String registerRole;

    /**
     * 注册时间
     */
    private Date registrationDate;
}
