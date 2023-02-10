package com.zimax.mcrs.basic.logDeleteRule.mapper;

import com.zimax.mcrs.basic.logDeleteRule.pojo.LogDeleteRule;
import com.zimax.mcrs.basic.logDeleteRule.pojo.LogDeleteRuleVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
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
     * 查询全部日志删除规则
     *
     * @return
     */
    List<LogDeleteRuleVo> queryAll(Map map);

    /**
     * 计数
     *
     * @return
     */
    int count(@Param("deleteRuleTitle") String deleteRuleTitle,
              @Param("logType") String logType);


    /**
     * 修改删除规则
     * @param logDeleteRule
     */
    void updateLogDeleteRule(LogDeleteRule logDeleteRule);

    /**
     * 启用
     */
    void enable(LogDeleteRule logDeleteRule);

    /**
     * 判断当前启用是否唯一
     */
    int checkEnable(@Param("logType") String logType);

    /**
     * 查询日志删除规则
     */
    List<LogDeleteRuleVo> selectLogDeleteRule(Map map);

    /**
     * 定时删除
     */
    void deleteLog(@Param("logType")String logType,@Param("deleteTime")String deleteTime);

    /**
     * 根据主键查询日志删除规则信息
     */
    LogDeleteRule queryLogDeleteRule(@Param("ruleDeleteId")int ruleDeleteId);
}
