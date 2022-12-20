package com.zimax.mcrs.warn.controller;


import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.warn.pojo.AlarmEvent;
import com.zimax.mcrs.warn.pojo.AlarmRule;
import com.zimax.mcrs.warn.service.AlarmEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 预警事件管理
 * @author 林俊杰
 * @date 2022/11/29
 */
@RestController
@RequestMapping("/warn")
public class AlarmEventController {

    @Autowired
    private AlarmEventService alarmEventService;

    /**
     * 条件查询预警事件d
     * @param alarmEventId 告警事件编码
     * @param alarmEventTitle 告警事件标题
     * @param alarmLevel 告警级别
     * @param alarmCategory 告警分类
     * @param alarmType 告警类型
     * @param makeFormPeople 制单人
     * @param limit 记录数
     * @param page 页码
     * @return 角色列表
     */
    @GetMapping("/alarmEvent/query")
    public Result<?> query(Integer alarmEventId, String alarmEventTitle, String alarmLevel, String alarmCategory,  String alarmType, String makeFormPeople, String makeFormTime, String limit,  String page, String order, String field) {
        List alarmEvents = alarmEventService.queryAll(page,limit,alarmEventId,alarmEventTitle,alarmLevel,alarmCategory,alarmType,makeFormPeople,makeFormTime,order,field);
        return Result.success(alarmEvents, alarmEventService.count(alarmEventId,alarmEventTitle));
    }

    /**
     * 添加告警事件
     * @param alarmEvent 预警事件
     */
    @PostMapping("/alarmEvent/add")
    public Result<?> addAlarmRule(@RequestBody AlarmEvent alarmEvent){
        alarmEventService.addAlarm(alarmEvent);
        return Result.success();
    }

    /**
     * 删除告警事件
     * @param alarmEventInt 预警事件编码
     */
    @DeleteMapping("/alarmEvent/delete/{alarmEventInt}")
    public Result<?> removeAlarmEvent(@PathVariable("alarmEventInt")int alarmEventInt) {
        alarmEventService.removeAlarm(alarmEventInt);
        return  Result.success();
    }

    /**
     * 修改告警事件
     * @param alarmEvent 预警规则
     */
    @PostMapping("/alarmEvent/update")
    public Result<?> updateAlarmEvent(@RequestBody AlarmEvent alarmEvent) {
        alarmEventService.updateAlarm(alarmEvent);
        return Result.success();
    }

//    /**
//     * 修改启停用
//     * @param alarmEvent 预警规则
//     */
//    @PostMapping("/alarmEvent/update")
//    public Result<?> enableAlarmEvent(@RequestBody AlarmEvent alarmEvent) {
//        alarmEventService.enableAlarm(alarmEvent);
//        return Result.success();
//    }


    /**
     * 批量删除告警事件
     * @param alarmEventInt 告警事件主键数组
     */
    @DeleteMapping("/alarmEvent/batchDelete")
    public Result<?> deleteDevices(@RequestBody Integer[] alarmEventInt) {
        alarmEventService.deleteAlarmEvents(Arrays.asList(alarmEventInt));
        return Result.success();

    }


}
