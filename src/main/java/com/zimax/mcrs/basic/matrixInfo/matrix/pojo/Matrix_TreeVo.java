package com.zimax.mcrs.basic.matrixInfo.matrix.pojo;

import lombok.Data;

/**
 * @author 李伟杰
 * @date 2022/12/26 14:06
 */
@Data
public class Matrix_TreeVo {

    /**
     * 上级id
     */

    private Integer parentId;

    /**
     * 基地名称
     */
    private String matrixName;

    /**
     * 基地代号
     */
    private String matrixCode;

    /**
     * 树id
     */
    private String infoId;
}
