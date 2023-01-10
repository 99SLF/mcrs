package com.zimax.mcrs.warn.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 预警规则监控对象
 * @author 林俊杰
 * @date 2023/1/7
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("war_monitor_equipment")
public class MonitorEquipment {

    /**
     * 监控对象主键
     */
    @TableId(type = IdType.AUTO)
    private int monitorEquipmentId;

    /**
     * 预警规则主键
     */
    private int alarmRuleInt;

    /**
     * 监控对象主键（监控对象为设备，即为设备主键）
     */
    private int equipmentInt;


}
