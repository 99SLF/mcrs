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
@TableName("dev_plcparam_dispose")
public class PlcPoint {
    /**
     * plc参数配置主键
     */
    @TableId(type = IdType.AUTO)
    int plcParamId;
    /**
     * 映射地址
     */
    String shineAddr;
    /**
     * 标签名称
     */
    String lableName;
    /**
     * 数据类型
     */
    String dataType;
    /**
     * 参数长度
     */
    Integer paramLen;
    /**
     * 小数位数长度
     */
    Integer smallPoint;
    /**
     * 中文释义
     */
    String chineseMean;
    /**
     * 备注
     */
    String remarks;
    /**
     * plc组外键Id
     */
    int plcGroupId;
}
