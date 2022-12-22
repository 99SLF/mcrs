package com.zimax.mcrs.basic.treeStructure.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 李伟杰
 * @date 2022/12/21 9:11
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("bas_tree")
public class TreeTemplate {

    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private int infoId;

    /**
     * 树名
     */

    private String infoName;

    /**
     * 排序
     */

    private Integer displayOrder;

    /**
     * 拼接编号
     */

    private String infoSeq;

    /**
     * 子类总数
     */

    private Integer subCount;

    /**
     * 子类类型
     */

    private String infoType;

    /**
     * 上级id
     */

    private Integer parentId;

    /**
     * 逻辑状态
     */
    private Integer logicStates;


}
