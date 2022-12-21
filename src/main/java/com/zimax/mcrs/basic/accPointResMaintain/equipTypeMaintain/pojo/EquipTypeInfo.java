package com.zimax.mcrs.basic.accPointResMaintain.equipTypeMaintain.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 设备类型维护
 * @author 李伟杰
 * @date 2022/12/19 11:57
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("bas_equipType_info")
public class EquipTypeInfo {

    /**
     * 设备信息数据的主键
     */
    @TableId(type = IdType.AUTO)
    private int equipTypeId;

    /**
     * 设备类型
     */
    private String equipTypeName;

    /**
     * 厂家
     */
    private String equipTypeCode;

    /**
     * 是否启用
     */
    private String equipTypeEnable;

    /**
     * 使用控制器型号
     */
    private String equipTypeModel;

    /**
     * 支持通信协议
     */
    private String protocolCommunication;

    /**
     * 备注
     */
    private String remarks;

}
