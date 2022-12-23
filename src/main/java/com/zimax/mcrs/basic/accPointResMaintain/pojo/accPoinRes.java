package com.zimax.mcrs.basic.accPointResMaintain.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import java.util.Date;

/**
 * 接入点信息
 * @author 李伟杰
 * @date 2022/12/23 9:42
 */
public class accPoinRes {


    /**
     * 接入点资源维护数据的主键
     */
    @TableId(type = IdType.AUTO)
    private int accPoinResId;

    /**
     * 树id
     */
    private String infoId;

    /**
     * 接入点代码
     */
    private String equipTypeCode;

    /**
     *接入点名称
     */
    private String equipTypeName;


    /**
     *是否启用
     */
    //private String equipTypeName;

    /**
     *基地代码
     */


    /**
     * 厂家
     */
    private String manufacturer;



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
