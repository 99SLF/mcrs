package com.zimax.mcrs.monitor.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @author 李伟杰
 * @date 2023/1/3 10:35
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("mon_equipment_status")
public class EquipmentStatus {

    /**
     * 设备接入状态编号
     */
    @TableId(type = IdType.AUTO)
    private int equipmentStatusId;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 接入类型(plc或rfid)
     */
    private String accessType;


    /**
     * 接入状态(正常异常)
     */
    private String accessStatus;

    /**
     * 天线状态（plc可以可以为空，rfid必填）
     */
    private String antennaStatus;

    /**
     * 创建时间
     *
     */
    private Date createTime;

}
