package com.zimax.mcrs.basic.logDeleteRule.controller;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.basic.logDeleteRule.pojo.LogDeleteRule;
import com.zimax.mcrs.basic.logDeleteRule.pojo.LogDeleteRuleVo;
import com.zimax.mcrs.basic.logDeleteRule.service.LogDeleteRuleService;
import com.zimax.mcrs.basic.logDeleteRule.service.TimeApp;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;

import javax.annotation.PostConstruct;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ScheduledFuture;

/**
 * 日志删除规则
 *
 * @author 林俊杰
 * @date 2022/12/21
 */
@RestController
@ResponseBody
@RequestMapping("/logDeleteRule")
public class LogDeleteRuleController {
    @Autowired
    private LogDeleteRuleService logDeleteRuleService;

    private Date deleteTime;


    /**
     * 条件查询
     *
     * @param deleteRuleTitle 删除规则标题
     * @param logType         日志类型
     * @param limit           记录数
     * @param page            页码
     * @param field           排序字段
     * @param order           排序方式
     * @return 删除规则列表
     */
    @GetMapping("/logDeleteRule/query")
    public Result<?> queryLogDeleteRule(String page, String limit, String deleteRuleTitle, String logType, String order, String field) {
        List logDeleteRules = logDeleteRuleService.queryLogDeleteRule(page, limit, deleteRuleTitle, logType, order, field);
        return Result.success(logDeleteRules, logDeleteRuleService.count(deleteRuleTitle, logType));
    }

//    /**
//     * 添加日志删除规则
//     */
//    @PostMapping("/logDeleteRule/add")
//    public Result<?> addLogDeleteRule(@RequestBody LogDeleteRule logDeleteRule) {
//        logDeleteRuleService.addLogDeleteRule(logDeleteRule);
//        return Result.success();
//    }


//    /**
//     * 删除日志删除规则
//     *
//     * @param ruleDeleteId 设备主键
//     */
//    @DeleteMapping("/logDeleteRule/delete/{ruleDeleteId}")
//    public Result<?> removeLogDeleteRule(@PathVariable("ruleDeleteId") int ruleDeleteId) {
//        logDeleteRuleService.removeLogDeleteRule(ruleDeleteId);
//        return Result.success();
//    }

    /**
     * 修改日志删除规则
     */
    @PostMapping("/logDeleteRule/update")
    public Result<?> updateLogDeleteRule(@RequestBody LogDeleteRule logDeleteRule) throws Exception {
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        logDeleteRule.setUpdater(userObject.getUserId());
        logDeleteRule.setUpdateTime(new Date());
        if (logDeleteRule.getEnable().equals("101")) {
            stopName(logDeleteRule.getLogType());
            enableTime(logDeleteRule.getLogType(), logDeleteRule.getRetentionTime());
        } else if (logDeleteRule.getEnable().equals("102")) {
//            stopName(logDeleteRule.getLogType());
        }
        logDeleteRuleService.updateLogDeleteRule(logDeleteRule);
        return Result.success();
    }

//    /**
//     * 批量删除日志删除规则
//     *
//     * @param ruleDeleteIds 日志删除规则主键数组
//     */
//    @DeleteMapping("/logDeleteRule/batchDelete")
//    public Result<?> deleteLogDeleteRules(@RequestBody Integer[] ruleDeleteIds) {
//        logDeleteRuleService.deleteLogDeleteRules(Arrays.asList(ruleDeleteIds));
//        return Result.success();
//
//    }


//    /**
//     * 检测日志删除规则是否存在
//     *
//     * @param deleteRuleNum 日志删除规则编码
//     */
//    @GetMapping("/logDeleteRule/check/isExist")
//    public Result<?> check(@RequestParam("deleteRuleNum") String deleteRuleNum) {
//        if (logDeleteRuleService.checkLogDeleteRule(deleteRuleNum) > 0) {
//            return Result.error("1", "当前日志删除规则编码已存在，请输入正确日志删除规则编码");
//        } else {
//            return Result.success();
//        }
//    }

    /**
     * 启用日志删除规则
     *
     * @param logDeleteRule 日志删除规则主键数组
     */
    @PostMapping("/logDeleteRule/enable")
    public Result<?> enable(@RequestBody List<LogDeleteRule> logDeleteRule) {
        logDeleteRuleService.enable(logDeleteRule);
        LogDeleteRule logDeleteRule1 = new LogDeleteRule();
        for (LogDeleteRule i : logDeleteRule) {
//            enableTime(i.getLogType(), i.getRetentionTime());
            selectDeleteRule();
        }

        return Result.success();
    }

    /**
     * 检测日志删除规则是否存在已启用规则
     *
     * @param logType 日志类型
     */
    @GetMapping("/logDeleteRule/check/enable")
    public Result<?> checkEnable(@RequestParam("logType") String logType) {
        if (logDeleteRuleService.countLogType(logType) > 0) {
            return Result.error("1", "当前日志已启用，请先关闭规则");
        } else {
            return Result.success();
        }
    }

    /**
     * 定时器启动
     *
     * @param logType
     * @param retentionTime
     */
    public void enableTime(String logType, int retentionTime) {
        String[] a = {"0", "0", "0", "1/1", "*", "?"};

        Date b = new Date();//获取当前时间
        Calendar rightNow = Calendar.getInstance();

        rightNow.setTime(b);

//        Calendar calendar = new GregorianCalendar();
//        //获取当天
//        int day = calendar.get(Calendar.DAY_OF_MONTH);
//        //获取当前小时
//        int hour = calendar.get(Calendar.HOUR_OF_DAY);
//        //获取当前分钟
//        int minute = calendar.get(Calendar.MINUTE);
//
        //依据时间单位的数据字典拼接corn
//        switch (timeUnit) {
//            case "101":

        //日期减去时间数(天)
        rightNow.add(Calendar.DATE, -retentionTime);
//                break;

//        }
        Date c = rightNow.getTime();//最后的时间
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String d = sdf2.format(c);
        System.out.println("====================" + d);
        //主要目的是获取corn生成的长度
        String corn1 = Arrays.toString(a).replace(",", "");
        //生成corn，并去除首尾的[]
        String corn = Arrays.toString(a).replace(",", "").substring(1, corn1.length() - 1);
//        System.out.println(Arrays.toString(a));
//        System.out.println(corn);
//        startCron(corn, logType);
        System.out.println("======================" + corn + logType);
    }


    /**
     * 线程储存
     */
    @Autowired
    private TimeApp timeApp;
    private ScheduledFuture future;

    /**
     * @param cron
     * @param logType
     */
    public void startCron(String cron, String logType) {
        //时间处理
        //String cron = "0/1 * * * * ?";
        System.out.println(cron);
        //线程名称
        System.out.println(Thread.currentThread().getName());
        //开启线程
        future = timeApp.threadPoolTaskScheduler().schedule(new myTask(logType), new CronTrigger(cron));
        //线程存储
        timeApp.map.put(logType, future);

    }


    /**
     * 关闭线程
     *
     * @param logType
     * @throws Exception
     */
    public void stopName(String logType) throws Exception {
        // 用线程名获取线程
        ScheduledFuture scheduledFuture = timeApp.map.get(logType);
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
//            logDeleteRuleService.deleteLog(deleteTime);
//            System.out.println(logInterfaceTime);
        }
    }

    //@PostConstruct 这个注解是在程序开始的时候会执行一次。不需要的话可以去掉
//    @PostConstruct
    //@Scheduled 用于定时任务控制的注解,主要用于控制任务在某个指定时间执行,或者每隔一段时间执行
    //每天00:00:00执行
    @Scheduled(cron = "0 0 0 * * ?")
    //每5秒执行一次
//    @Scheduled(cron = "0/5 * * * * ?")
    public void selectDeleteRule() {
        List<LogDeleteRuleVo> logDeleteRules = logDeleteRuleService.selectLogDeleteRule();
        for (LogDeleteRuleVo logDeleteRule : logDeleteRules) {
            if (logDeleteRule.getEnable().equals("101")) {
                //获取当前时间
                Date a = new Date();
                Calendar rightNow = Calendar.getInstance();
                rightNow.setTime(a);
                rightNow.add(Calendar.DATE, -logDeleteRule.getRetentionTime());
                //最后的时间
                Date b = rightNow.getTime();
                SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                //将最后得到的时间转化时间格式赋值给c
                String deleteTime = sdf2.format(b);
                logDeleteRuleService.deleteLog(logDeleteRule.getLogType(), deleteTime);
            }
        }
    }
}