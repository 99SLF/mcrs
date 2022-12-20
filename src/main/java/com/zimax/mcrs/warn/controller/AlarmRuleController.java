package com.zimax.mcrs.warn.controller;

import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.warn.pojo.AlarmRule;
import com.zimax.mcrs.warn.service.AlarmEventService;
import com.zimax.mcrs.warn.service.AlarmRuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 预警规则管理
 * @author 林俊杰
 * @date 2022/11/29
 */
@RestController
@ResponseBody
@RequestMapping("/warn")
public class AlarmRuleController {

    @Autowired
    private AlarmRuleService alarmRuleService;

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
     * @param alarmRuleId 预警规则编码
     * @param alarmRuleTitle 预警规则标题
     * @param monitorLevel 监控层级
     * @param enable 是否启用
     * @param alarmEventId 告警事件编码
     * @param monitorObject 监控对象
     * @param ruleMakeFormPeople 规则制单人
     * @param ruleMakeFormTime 规则制单时间
     * @param limit 记录数
     * @param page 页码
     * @param field 排序字段
     * @param order 排序方式
     * @return 预警规则列表
     */
    @GetMapping("/alarmRule/query")
    public Result<?> queryAlarmRule(String page, String limit, Integer alarmRuleId, String alarmRuleTitle,String enable, String monitorLevel, String alarmEventId, String monitorObject, String ruleMakeFormPeople, String ruleMakeFormTime, String order, String field) {
        List alarmRules =  alarmRuleService.queryAlarmRule(page,limit,alarmRuleId,alarmRuleTitle,enable,monitorLevel,alarmEventId,monitorObject,ruleMakeFormPeople,ruleMakeFormTime,order,field);
        return Result.success( alarmRules,alarmRuleService.count(alarmRuleId,alarmRuleTitle));
    }

    /**
     * 添加预警规则
     * @param alarmRule 预警规则
     */
    @PostMapping("/alarmRule/add")
    public Result<?> addAlarmRule(@RequestBody AlarmRule alarmRule){
        alarmRuleService.addAlarmRule(alarmRule);
        return Result.success();
    }

    /**
     * 删除预警规则
     * @param alarmRuleInt 预警规则编码
     */
    @DeleteMapping("/alarmRule/delete/{alarmRuleInt}")
    public Result<?> removeAlarmRule(@PathVariable("alarmRuleInt")int alarmRuleInt) {
        alarmRuleService.removeAlarmRule(alarmRuleInt);
        return  Result.success();
    }

    /**
     * 修改预警规则
     * @param alarmRule 预警规则
     */
    @PostMapping("/alarmRule/update")
    public Result<?> updateAlarmRule(@RequestBody AlarmRule alarmRule) {
        alarmRuleService.updateAlarmRule(alarmRule);
        return Result.success();
    }


    /**
     * 批量删除告警规则
     * @param alarmRuleInt 预警规则主键数组
     */
    @DeleteMapping("/alarmRule/batchDelete")
    public Result<?> deleteDevices(@RequestBody Integer[] alarmRuleInt) {
        alarmRuleService.deleteAlarmRules(Arrays.asList(alarmRuleInt));
        return Result.success();

    }


}
