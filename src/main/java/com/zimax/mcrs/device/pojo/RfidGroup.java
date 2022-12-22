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
@TableName("dev_rfid_group")
public class RfidGroup {
    /**
     * rfid主键
     */
    @TableId(type = IdType.AUTO)
    int rfidGroupId;
    /**
     * rfid编号
     */
    String rfidNum;
    /**
     * ip地址
     */
    String ipAddr;
    /**
     * 端口号
     */
    String port;
    /**
     * appId
     */
    String appId;
    @TableField(exist = false)
    List<RfidPoint> rfidPointList;
}
