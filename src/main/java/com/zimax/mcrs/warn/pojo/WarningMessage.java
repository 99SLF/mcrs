package com.zimax.mcrs.warn.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 警告信息
 * @author 林俊杰
 * @date 2022/11/29
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("WarningMessage")
public class WarningMessage {

    // 警告信息编号
    @TableId(type = IdType.AUTO)
    private int waringMessageId;

    //设备编号
    private int deviceId;

    //用户名称
    private String userName;

    //警告编号
    private int waringId;

    //警告信息
    private String waringMessage;

    //警告时间
    private Date waringTime;

}
