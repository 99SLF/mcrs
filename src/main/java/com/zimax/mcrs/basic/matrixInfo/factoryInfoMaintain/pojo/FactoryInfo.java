package com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 工厂信息维护
 * @author 李伟杰
 * @date 2022/12/19 11:20
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("base_factory_info")
public class FactoryInfo {

    /**
     * 工厂信息数据的主键
     */
    @TableId(type = IdType.AUTO)
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
