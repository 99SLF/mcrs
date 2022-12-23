package com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo;

import lombok.Data;



/**
 * @author 李伟杰
 * @date 2022/12/23 13:34
 */
@Data
public class FactoryInfoVo {

    /**
     * 工厂信息数据的主键
     */

    private int factoryId;

    /**
     * 树id
     */
    private int infoId;

    /**
     * 工厂名称
     */
    private String factoryName;

    /**
     * 工厂代号
     */
    private String factoryCode;


    /**
     * 工厂地址
     */
    private String factoryAddress;

    /**
     * 制单人
     */
    private String creator;


    /**
     * 制单时间
     */
    private String createTime;

    /**
     * 修改人
     */
    private String updater;

    /**
     * 修改时间
     */
    private String updateTime;
}


