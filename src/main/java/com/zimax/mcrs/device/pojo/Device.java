package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 设备
 * @author 林俊杰
 * @date 2022/11/28
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("device")
public class Device {

    // 设备编号
    @TableId
    private int deviceId;

    //版本号
    private String deviceVersion;

    //用户名称
    private String userName;

    //设备状态码
    private String deviceStatus;

    //创建人
    private String creator;

    //创建时间
    private Date createTime;

}
