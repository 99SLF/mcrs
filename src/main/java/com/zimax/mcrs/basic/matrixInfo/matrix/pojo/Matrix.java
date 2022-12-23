package com.zimax.mcrs.basic.matrixInfo.matrix.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 基础基地信息
 * @author 李伟杰
 * @date 2022/12/23 10:11
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("base_matrix_info")
public class Matrix {

    /**
     * 基础基地数据的主键
     */
    @TableId(type = IdType.AUTO)
    private int matrixId;

    /**
     * 树id
     */
    private String infoId;

    /**
     * 基地名称
     */
    private String matrixName;

    /**
     * 基地代号
     */
    private String matrixCode;

    /**
     *基地地址
     */
    private String matrixAddress;

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
