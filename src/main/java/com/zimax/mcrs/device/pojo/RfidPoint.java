package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author 施林丰
 * @Date:2022/12/19 11:07
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("dev_rfidparam_dispose")
public class RfidPoint {
    /**
     * rfid点位主键
     */
    @TableId(type = IdType.AUTO)
    /**
     * rfid参数编码
     */
    int rfidParamId;
    /**
     * 参数名字
     */
    String paramName;
    /**
     * 参数主键
     */
    String paramKey;
    /**
     * 参数值
     */
    String paramValue;
    /**
     * 参数标记
     */
    String paramMark;
    /**
     * 备注
     */
    String remarks;
    int rfidGroupId;
}
