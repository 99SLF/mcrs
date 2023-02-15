package com.zimax.mcrs.monitor.pojo.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.util.Date;

/**
 * @author 李伟杰
 * @date 2023/2/9 15:32
 */
@Data
public class EquipmentStatusVo {

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * 终端状态表主键
     */

    private int deviceRealId;

    /**
     * 设备主键
     */
    private int equipmentInt;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 接入类型(plc或rfid)   ACCESS_TYPE
     * 101
     * PLC
     *
     * 102
     * RFID
     *
     */
    private String accessType;



    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * 接入状态(正常异常)
     * EQUIPMENT_ACCESS_STATUS
     * 101
     * 正常
     *
     * 102
     * 异常
     *
     */
    private String accessStatus;

    /**
     * 天线状态（plc可以可以为空，rfid必填）
     *
     * ANTENNA_TYPE
     * 101
     * 正常
     *
     * 102
     * 异常
     *
     */
    private String antennaStatus;


}