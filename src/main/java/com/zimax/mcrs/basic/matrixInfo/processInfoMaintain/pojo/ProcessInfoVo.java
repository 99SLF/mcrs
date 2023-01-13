package com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;



/**
 * @author 李伟杰
 * @date 2022/12/23 13:49
 */
@Data
public class ProcessInfoVo {

    /**
     * 工序信息数据的主键
     */

    private int processId;

    /**
     * 树id
     */
    private String infoId;

    /**
     * 工序名称
     */
    private String processName;

    /**
     * 工序代号
     */
    private String processCode;

    /**
     * 工序信息描述
     */
    private String processRemarks;

    /**
     * 制单人
     */
    private String creator;

    /**
     * 工厂信息数据的主键
     */

    private int factoryId;


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
