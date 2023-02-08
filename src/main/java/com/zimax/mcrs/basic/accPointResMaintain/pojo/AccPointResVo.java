package com.zimax.mcrs.basic.accPointResMaintain.pojo;

import lombok.Data;

/**
 * @author 李伟杰
 * @date 2022/12/24 23:01
 */
@Data
public class AccPointResVo {

    /**
     * 接入点资源维护数据的主键
     */
    private int accPointResId;

//    /**
//     * 树id
//     */
//    private int infoId;

    /**
     * 接入点代码
     */
    private String accPointResCode;

    /**
     *接入点名称
     */
    private String accPointResName;


    /**
     *是否启用
     */
    private String isEnable;

    /**
     *基地代码
     */
    private String matrixCode;

    /**
     * 基地名称
     */
    private String matrixName;



    /**
     * 工厂代码
     */
    private String factoryCode;

    /**
     * 工厂名称
     */
    private String factoryName;


    /**
     * 工序id
     */
    private String processId;

    /**
     * 工序代码
     */
    private String processCode;

    /**
     * 工序名称
     */
    private String processName;

    /**
     * 工序描述
     */
    private String processRemarks;

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


    private String accCreatorName;

    private String accUpdaterName;

}
