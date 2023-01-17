package com.zimax.mcrs.basic.accPointResMaintain.pojo;
import com.baomidou.mybatisplus.annotation.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 接入点信息
 * @author 李伟杰
 * @date 2022/12/23 9:42
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("base_access_info")
public class AccPointRes {


    /**
     * 接入点资源维护数据的主键
     */
    @TableId(type = IdType.AUTO)
    private Integer accPointResId;

    /**
     * 树id
     */
    private int infoId;

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
     * 工厂代码
     */
    private String factoryCode;


    /**
     * 工序代码
     */
    private String processCode;


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
