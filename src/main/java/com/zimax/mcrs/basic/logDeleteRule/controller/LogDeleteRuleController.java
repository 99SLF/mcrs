package com.zimax.mcrs.basic.logDeleteRule.controller;

import com.zimax.mcrs.basic.logDeleteRule.pojo.LogDeleteRule;
import com.zimax.mcrs.basic.logDeleteRule.service.LogDeleteRuleService;
import com.zimax.mcrs.basic.logDeleteRule.service.TimeApp;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Timer;
import java.util.concurrent.ScheduledFuture;

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
     * 启用日志删除规则
     *
     * @param ruleDeleteIds 日志删除规则主键数组
     */
    @PostMapping("/logDeleteRule/enable")
    public Result<?> enable(@RequestBody List<Integer> ruleDeleteIds) {
        logDeleteRuleService.enable(ruleDeleteIds);
        return Result.success();

    }


    /**
     * 线程储存
     */
    @Autowired
    private TimeApp timeApp;
    private ScheduledFuture future;

    /**
     * 开启线程
     * @param name
     */
    @GetMapping("/testStart")
    public void startCron(String name) {
        //时间处理
        String cron = "0/1 * * * * ?";
        //线程名称
        System.out.println(Thread.currentThread().getName());
        //开启线程
        future = timeApp.threadPoolTaskScheduler().schedule(new myTask(name), new CronTrigger(cron));
       //线程存储
        timeApp.map.put(name, future);
    }


    /**
     * 关闭线程
     * @param name
     * @throws Exception
     */
    @GetMapping("/testStoop")
    public void stopName(String name) throws Exception {
        // 用线程名获取线程
        ScheduledFuture scheduledFuture = timeApp.map.get(name);
        //线程关闭
        scheduledFuture.cancel(true);
        // 查看任务是否在正常执行之前结束,正常true
        boolean cancelled = scheduledFuture.isCancelled();
        while (!cancelled) {
            scheduledFuture.cancel(true);
        }
    }


    /**
     * 线程任务处理
     */
    private class myTask implements Runnable {
        private String name;

        myTask(String name) {
            this.name = name;
        }

        @Override
        public void run() {
            //线程执行
            System.out.println("test" + name);
        }
    }


}
