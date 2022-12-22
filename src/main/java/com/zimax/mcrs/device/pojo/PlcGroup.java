package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @Author 施林丰
 * @Date:2022/12/20 10:43
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("dev_plc_group")
public class PlcGroup {
    /**
     * plc点位组主键
     */
    @TableId(type = IdType.AUTO)
    int plcGroupId;
    /**
     * plc点位组名称
     */
    String plcGroupName;
    /**
     * plc功能组类型
     */
    String plcGroupType;
    /**
     * plc映射RFID名称
     */
    String plcGroupRname;
    /**
     * rfid编号
     */
    String rfidNum;
    /**
     * 备注
     */
    String remarks;
    /**
     * appId
     */
    String appId;
    @TableField(exist = false)
    List<PlcPoint> plcPointList;

}
