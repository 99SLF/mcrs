package com.zimax.mcrs.warn.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 警告规则
 * @author 林俊杰
 * @date 2022/11/29
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("waringRule")
public class WarningRule {

    /**
     * 预警编号
     */
    @TableId(type = IdType.AUTO)
    private int waringId;

    /**
     * 警告规则名称
     */
    private String waringMessageName;

    /**
     * 上限
     */
    private String topLimit;

    /**
     * 下限
     */
    private String underLimit;

    /**
     * 固定值
     */
    private String fixed;

    /**
     * 警告规则文本
     */
    private String waringRule;

    /**
     * 备注
     */
    private String remarks;
}
