package com.zimax.mcrs.basic.accPointResMaintain.factoryInfoMaintain.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 工厂信息维护
 * @author 李伟杰
 * @date 2022/12/19 11:20
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("bas_factory_info")
public class FactoryInfo {

    /**
     * 工厂信息数据的主键
     */
    @TableId(type = IdType.AUTO)
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
     * 工厂是否启用
     */
    private String factoryEnable;

    /**
     * 工厂地址
     */
    private String factoryAddress;
}
