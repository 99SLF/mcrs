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
     * 依据条件查询预警事件
     * @param page 页码
     * @param limit 条数
     * @param alarmEventId 预警规则编码
     * @param alarmEventTitle 预警规则标题
     * @param enableStatus 启用状态
     * @param alarmLevel 预警等级
     * @param alarmType 预警类型
     * @param createName 创建人
     * @param makeFormTime 制单时间(创建时间)
     * @param updateName 更新人
     * @param updateTime 更新时间
     * @param order
     * @param field
     * @return
     */
    @GetMapping("/alarmEvent/query")
    public Result<?> query(String page, String limit, String alarmEventId, String alarmEventTitle, String enableStatus, String alarmLevel,
                           String alarmType, String createName, String makeFormTime,String updateName, String updateTime, String order, String field) {
        List alarmEvents = alarmEventService.queryAll(page,limit,alarmEventId,alarmEventTitle,enableStatus,alarmLevel,alarmType,createName,makeFormTime,updateName,updateTime,order,field);
        return Result.success(alarmEvents, alarmEventService.count(alarmEventId,alarmEventTitle,enableStatus,alarmLevel,alarmType,createName,makeFormTime,updateName,updateTime));
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


    /**
     * 批量启用告警事件
     * @param alarmEventInt 告警事件主键数组
     */
    @PostMapping("/alarmEvent/enable")
    public Result<?> enable(@RequestBody List<Integer> alarmEventInt) {
        alarmEventService.enable(alarmEventInt);
        return Result.success();

    }

    /**
     * 检测预警事件编码是否存在
     *
     * @param alarmEventId 预警事件编码
     */
    @GetMapping("/alarmEvent/check/isExist")
    public Result<?> check(@RequestParam("alarmEventId") String alarmEventId) {
        if(alarmEventService.checkAlarmEvent(alarmEventId)>0){
            return Result.error("1","当前预警规则编码已存在，请输入正确的预警规则编码");
        }else {
            return Result.success();
        }
    }

}
