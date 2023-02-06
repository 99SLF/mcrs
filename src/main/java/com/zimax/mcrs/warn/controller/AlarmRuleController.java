package com.zimax.mcrs.warn.controller;

import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.warn.pojo.AlarmRule;
import com.zimax.mcrs.warn.pojo.MonitorEquipment;
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
     * 查询
     * @param page 页码
     * @param limit 条数
     * @param alarmRuleId 预警规则编码
     * @param alarmRuleTitle 预警规则标题
     * @param enable 启用
     * @param monitorLevel 监控等级
     * @param alarmRuleDescribe 预警规则面熟
     * @param createName 创建人
     * @param ruleMakeFormTime 规则创建时间
     * @param updateName 更新人
     * @param ruleUpdateTime 规则更新时间
     * @param order
     * @param field
     * @return
     */
    @GetMapping("/alarmRule/query")
    public Result<?> queryAlarmRule(String page, String limit, String alarmRuleId, String alarmRuleTitle, String enable, String monitorLevel, String alarmRuleDescribe, String createName, String ruleMakeFormTime, String updateName, String ruleUpdateTime, String order, String field) {
        List alarmRules =  alarmRuleService.queryAlarmRule(page,limit,alarmRuleId,alarmRuleTitle,enable,monitorLevel,alarmRuleDescribe,createName,ruleMakeFormTime, updateName,ruleUpdateTime,order,field);
        return Result.success( alarmRules,alarmRuleService.count(alarmRuleId,alarmRuleTitle,enable,monitorLevel,alarmRuleDescribe,createName,ruleMakeFormTime, updateName,ruleUpdateTime));
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

    /**
     * 查询预警规则对应的监控对象
     * @param alarmRuleInt 预警规则主键
     * @return
     */
    @GetMapping("/alarmRule/MonitorEquipment/get")
    public Result<?> getMonitorEquipmentVo(int alarmRuleInt) {
        return Result.success(alarmRuleService.getMonitorEquipmentVo(alarmRuleInt));
    }


    /**
     * 检测预警规则编码是否存在
     *
     * @param alarmRuleId 设备资源号
     */
    @GetMapping("/alarmRule/check/isExist")
    public Result<?> check(@RequestParam("alarmRuleId") String alarmRuleId) {
        if(alarmRuleService.countAlarmRule(alarmRuleId)>0){
            return Result.error("1","当前预警规则编码已存在，请输入正确的预警规则编码");
        }else {
            return Result.success();
        }
    }

}
