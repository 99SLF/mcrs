package com.zimax.mcrs.basic.logDeleteRule.controller;

import com.zimax.mcrs.basic.logDeleteRule.pojo.LogDeleteRule;
import com.zimax.mcrs.basic.logDeleteRule.service.LogDeleteRuleService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 日志删除规则
 * @author 林俊杰
 * @date 2022/12/21
 */
@RestController
@ResponseBody
@RequestMapping("/logDeleteRule")
public class LogDeleteRuleController {
    @Autowired
    private LogDeleteRuleService logDeleteRuleService;

    /**
     * 条件查询
     *
     * @param deleteRuleNum       删除规则编码
     * @param deleteRuleTitle 删除规则标题
     * @param ruleLevel 规则等级
     * @param deleteRuleType 删除规则类型
     * @param creator 创建人
     * @param limit       记录数
     * @param page        页码
     * @param field       排序字段
     * @param order       排序方式
     * @return 删除规则列表
     */
    @GetMapping("/logDeleteRule/query")
    public Result<?> queryLogDeleteRule (String  page, String limit, String deleteRuleNum, String deleteRuleTitle, String ruleLevel, String deleteRuleType, String creator,String order, String field) {
        List logDeleteRules = logDeleteRuleService.queryLogDeleteRule(page, limit, deleteRuleNum,deleteRuleTitle, ruleLevel,deleteRuleType,creator, order, field);
        return Result.success(logDeleteRules, logDeleteRuleService.count(deleteRuleNum));
    }

    /**
     * 添加日志删除规则
     */
    @PostMapping("/logDeleteRule/add")
    public Result<?> addLogDeleteRule(@RequestBody LogDeleteRule logDeleteRule){
        logDeleteRuleService.addLogDeleteRule(logDeleteRule);
        return Result.success();
    }


    /**
     * 删除日志删除规则
     *
     * @param ruleDeleteId 设备主键
     */
    @DeleteMapping("/logDeleteRule/delete/{ruleDeleteId}")
    public Result<?> removeLogDeleteRule(@PathVariable("ruleDeleteId") int ruleDeleteId) {
        logDeleteRuleService.removeLogDeleteRule(ruleDeleteId);
        return Result.success();
    }

    /**
     * 修改日志删除规则
     */
    @PostMapping("/logDeleteRule/update")
    public Result<?> updateLogDeleteRule(@RequestBody LogDeleteRule logDeleteRule){
        logDeleteRuleService.updateLogDeleteRule(logDeleteRule);
        return Result.success();
    }

    /**
     * 批量删除日志删除规则
     *
     * @param ruleDeleteIds 日志删除规则主键数组
     */
    @DeleteMapping("/logDeleteRule/batchDelete")
    public Result<?> deleteLogDeleteRules(@RequestBody Integer[] ruleDeleteIds) {
        logDeleteRuleService.deleteLogDeleteRules(Arrays.asList(ruleDeleteIds));
        return Result.success();

    }


    /**
     * 检测日志删除规则是否存在
     *
     * @param deleteRuleNum 日志删除规则编码
     */
    @GetMapping("/logDeleteRule/check/isExist")
    public Result<?> check(@RequestParam("deleteRuleNum") String deleteRuleNum) {
        if(logDeleteRuleService.checkLogDeleteRule(deleteRuleNum)>0){
            return Result.error("1","当前日志删除规则编码已存在，请输入正确日志删除规则编码");
        }else {
            return Result.success();
        }

    }


    /**
     * 批量启用日志删除规则
     *
     * @param ruleDeleteIds 日志删除规则主键数组
     */
    @PostMapping("/logDeleteRule/enable")
    public Result<?> enable(@RequestBody Integer[] ruleDeleteIds) {
        logDeleteRuleService.enable(Arrays.asList(ruleDeleteIds));
        return Result.success();

    }


}
