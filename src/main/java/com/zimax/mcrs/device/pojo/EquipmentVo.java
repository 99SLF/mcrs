package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

/**
 * 设备
 *
 * @author 林俊杰
 * @date 2023/1/5
 */
@Data
public class EquipmentVo {

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
     *设备类型名称
     */
    private String equipTypeName;

    /**
     *MES连接IP地址
     */
    private String mesIpAddress;

    /**
     * 支持通信协议
     */
    private String protocolCommunication;

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
     *接入点名称
     */
    private String accPointResName;

    /**
     *基地代码
     */
    private String matrixCode;

    /**
     * 工厂代码
     */
    private String factoryCode;

    /**
     * 工序名称
     */
    private String processName;

    /**
     * 是否启用
     */
    private String enable;

    /**
     * 创建人
     */
    @TableField(exist = false)
    private String createName;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 备注
     */
    private String remarks;

    /**
     *工位列表
     */
    @TableField(exist = false)
    List<WorkStation> workStationList;
}
