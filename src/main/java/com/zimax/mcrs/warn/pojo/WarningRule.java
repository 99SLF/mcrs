package com.zimax.mcrs.warn.pojo;

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

    //警告编号
    @TableId
    private int waringId;

    //警告规则名称
    private String waringMessageName;

    //警告规则内容
    private String waringRule;
}
