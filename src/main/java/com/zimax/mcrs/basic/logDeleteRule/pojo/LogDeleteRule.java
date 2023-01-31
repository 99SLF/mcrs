package com.zimax.mcrs.basic.logDeleteRule.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 日志删除规则
 *
 * @author 林俊杰
 * @date 2022/12/21
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("bas_log_delete_rule")
public class LogDeleteRule {
    /**
     * 删除规则主键
     */
    @TableId(type = IdType.AUTO)
    private int ruleDeleteId;

    /**
     * 删除规则标题
     */
    private String deleteRuleTitle;

    /**
     * 是否启用
     */
    private String enable;

    /**
     * 日志删除规则类型
     */
    private String deleteRuleType;

    /**
     * 日志类型
     */
    private String logType;

    /**
     * 保留时间数
     */
    private int  retentionTime;

    /**
     * 修改人
     */
    private String updater;

    /**
     * 修改时间
     */
    private Date updateTime;

}
