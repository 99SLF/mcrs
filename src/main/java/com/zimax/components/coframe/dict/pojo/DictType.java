package com.zimax.components.coframe.dict.pojo;


import com.alibaba.excel.annotation.ExcelProperty;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 字典类型
 * @author 李伟杰
 * @date 2022/12/1
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("dict_type")
public class DictType {

    /**
     * 字典类型编号
     */
//    @ExcelProperty("字典类型编号")
    private String dictTypeId;

    /**
     * 字典类型名称
     */
//    @ExcelProperty("字典类型名")
    private String dictTypeName;

    /**
     * 连接
     */
    private int rank;

    /**
     * 父字典名称
     */
    private String parentId;

    /**
     * 序号
     */
    private String seqNo;

}
