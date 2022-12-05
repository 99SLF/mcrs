package com.zimax.mcrs.warn.controller;


import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.warn.service.AlarmEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 角色管理
 * @author 施林丰
 * @date 2022/11/28
 */
@RestController
@RequestMapping("/alarmEvent")
public class AlarmEventController {

    @Autowired
    private AlarmEventService alarmEventService;

    /**
     * 初始化查询
     * @param alarmEventId 告警事件编号
     * @return 告警事件
     */
    @RequestMapping("/find/{alarmEventId}")
    public Result<?> getAlarmEvent(@PathVariable("alarmEventId") int alarmEventId) {
        return Result.success();
    }

    /**
     * 条件查询角色
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
    @GetMapping("/query")
    public Result<?> queryRoles(@RequestParam int alarmEventId, @RequestParam String alarmEventTitle,@RequestParam String alarmLevel, @RequestParam String alarmCategory, @RequestParam String alarmType, @RequestParam String makeFormPeople, @RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }



}
