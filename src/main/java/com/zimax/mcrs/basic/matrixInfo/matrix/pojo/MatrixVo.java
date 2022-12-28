package com.zimax.mcrs.basic.matrixInfo.matrix.pojo;


import lombok.Data;

/**
 * @author 李伟杰
 * @date 2022/12/23 10:17
 */
@Data
public class MatrixVo {

    /**
     * 基础基地数据的主键
     */

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
