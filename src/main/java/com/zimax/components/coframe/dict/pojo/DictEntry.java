package com.zimax.components.coframe.dict.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 字典项
 * @author 李伟杰
 * @date 2022/12/1
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("dict_entry")
public class DictEntry {

    /**
     * 字典类型编号
     */
    private String dictTypeId;

    /**
     * 字典编号
     */
    private String dictId;

    /**
     * 字典名称
     */
    private String dictName;

    /**
     * 状态
     */
    private String status;

    /**
     * 排序
     */
    private String sortNo;

    /**
     * rank
     */
    private String rank;

    /**
     * 父级编号
     */
    private String parentId;

    /**
     * 序号
     */
    private String seqNo;

    /**
     * 字段1
     */
    private String filter1;

    /**
     * 字段2
     */
    private String filter2;


}
