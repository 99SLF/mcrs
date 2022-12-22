package com.zimax.mcrs.basic.logDeleteRule.mapper;

import com.zimax.mcrs.basic.logDeleteRule.pojo.LogDeleteRule;
import com.zimax.mcrs.basic.logDeleteRule.pojo.LogDeleteRuleVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 日志删除规则
 * @author 林俊杰
 * @date 2022/12/21
 */
@Mapper
public interface LogDeleteRuleMapper {

    /**
     * 查询全部终端信息
     *
     * @return
     */
    List<LogDeleteRuleVo> queryAll(Map map);


    /**
     * 计数
     *
     * @return
     */
    int count(@Param("deleteRuleNum") String deleteRuleNum);


    /**
     * 添加删除规则
     * @param logDeleteRule
     */
    void addLogDeleteRule(LogDeleteRule logDeleteRule);

    /**
     * 删除日志删除规则
     *
     * @return
     */
    void removeLogDeleteRule(int ruleDeleteId);

    /**
     * 修改删除规则
     * @param logDeleteRule
     */
    void updateLogDeleteRule(LogDeleteRule logDeleteRule);

    /**
     * 批量删除
     * @param ruleDeleteId
     */
    void deleteLogDeleteRules(List<Integer> ruleDeleteId);

    /**
     * 检查当前规则编码是否存在
     */
    int checkLogDeleteRule(@Param("deleteRuleNum") String deleteRuleNum);


    /**
     * 批量启用
     */
    int enable(LogDeleteRule logDeleteRule);

}
