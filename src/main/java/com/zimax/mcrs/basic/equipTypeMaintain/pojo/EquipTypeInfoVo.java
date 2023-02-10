package com.zimax.mcrs.basic.equipTypeMaintain.pojo;
import lombok.Data;



/**
 * 设备类型维护
 * @author 李伟杰
 * @date 2022/12/19 11:57
 */
@Data
public class EquipTypeInfoVo {

    /**
     * 设备信息数据的主键
     */

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
     * 创建人
     */
    private String equipCreatorName;


    /**
     * 制单时间
     */
    private String createTime;

    /**
     * 修改人
     */
    private String updater;

    /**
     * 修改人name
     */
    private String equipUpdaterName;

    /**
     * 修改时间
     */
    private String updateTime;

}
