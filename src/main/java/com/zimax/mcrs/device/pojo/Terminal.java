package com.zimax.mcrs.device.pojo;

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
@TableName("terminal")
public class Terminal {

    /**
     * APPId
     */
    @TableId
    private int APPId;

    /**
     * 设备资源号
     */
    private int deviceId;

    /**
     * 主机地址
     */
    private String hostAddress;

    /**
     * 终端软件类型
     */
    private String terminalType;

    /**
     * 注册人员
     */
    private String registrant;

    /**
     * 注册时间
     */
    private Date registrationDate;
}
