package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 设备
 *
 * @author 林俊杰
 * @date 2022/11/28
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("eqi_equipment")
public class Equipment {

    /**
     * 设备主键
     */
    @TableId(type = IdType.AUTO)
    private int equipmentInt;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * 设备安装位置
     */
    private String equipmentInstallLocation;

    /**
     * 设备信息主键
     */
    private int equipTypeId;

    /**
     * 设备连接端口
     */
    private String equipmentContinuePort;

    /**
     * 设备连接IP
     */
    private String equipmentIp;

    /**
     * 接入点资源维护数据的主键
     */
    private int accPointResId;

    /**
     * 是否启用
     */
    private String enable;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    private Date createTime;

    /**
     * 备注
     */
    private String remarks;



}
