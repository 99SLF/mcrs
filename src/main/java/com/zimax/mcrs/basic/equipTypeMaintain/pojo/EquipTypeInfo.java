package com.zimax.mcrs.basic.equipTypeMaintain.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 设备类型维护
 * @author 李伟杰
 * @date 2022/12/19 11:57
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("base_equip_info")
public class EquipTypeInfo {

    /**
     * 设备信息数据的主键
     */
    @TableId(type = IdType.AUTO)
    private int equipTypeId;

    /**
     * 树id
     */
    private String infoId;


    /**
     * 设备类型代码
     */
    private String equipTypeCode;

    /**
     * 是否启用
     */
    private String equipTypeEnable;

    /**
     * 厂家
     */
    private String manufacturer;

    /**
     *设备类型名称
     */
    private String equipTypeName;

    /**
     * 使用控制器型号
     */
    private String equipControllerModel;

    /**
     * 支持通信协议
     */
    private String protocolCommunication;

    /**
     *MES连接IP地址
     */
    private String mesIpAddress;

    /**
     * 备注
     */
    private String remarks;

    /**
     * 制单人
     */
    private String creator;


    /**
     * 制单时间
     */
    private Date createTime;

    /**
     * 修改人
     */
    private String updater;

    /**
     * 修改时间
     */
    private Date updateTime;

}
