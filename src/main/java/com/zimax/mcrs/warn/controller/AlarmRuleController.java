package com.zimax.mcrs.warn.controller;

import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.warn.pojo.AlarmRule;
import com.zimax.mcrs.warn.service.AlarmEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 预警规则管理
 * @author 林俊杰
 * @date 2022/11/29
 */
@RestController
@ResponseBody
@RequestMapping("/alarmRule")
public class AlarmRuleController {

    @Autowired
    private AlarmEventService alarmEventService;

    /**
     * 初始化查询
     * @param alarmRuleId 预警规则Id
     */
    @GetMapping("/find/{alarmRuleId}")
    public Result<?> queryAll(@PathVariable("alarmRuleId") int alarmRuleId) {
        return Result.success();
    }

    /**
     * 条件查询规则
     * @param alarmRuleId 告警规则编码
     * @param alarmRuleTitle 告警规则标题
     * @param monitorLevel 监控层级
     * @param alarmRuleStatus 告警规则状态
     * @param alarmEventId 告警事件编码
     * @param monitorObject 监控对象
     * @param makeFormPeople 制单人
     * @param limit 记录数
     * @param page 页码
     * @return 角色列表
     */
    @GetMapping("/query")
    public Result<?> select(@RequestParam int alarmRuleId, @RequestParam String alarmRuleTitle,@RequestParam String monitorLevel, @RequestParam String alarmRuleStatus, @RequestParam int alarmEventId, @RequestParam String monitorObject, @RequestParam String makeFormPeople, @RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }

    /**
     * 添加告警规则
     * @param alarmRule 预警规则
     */
    @RequestMapping("/add")
    public Result<?> addAlarmRule(@RequestBody AlarmRule alarmRule){
        return Result.success();
    }

    /**
     * 删除预警规则
     * @param alarmRuleId 预警规则编码
     */
    @DeleteMapping("/delete/{alarmRuleId}")
    public Result<?> deleteAlarmRule(@PathVariable("alarmRuleId")int alarmRuleId) {
        return  Result.success();
    }

    /**
     * 修改告警规则
     * @param alarmRule 预警规则
     */
    @PutMapping("/update")
    public Result<?> updateAlarmRule(@RequestBody AlarmRule alarmRule) {
        return Result.success();
    }


}
