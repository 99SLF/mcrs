package com.zimax.mcrs.warn.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.pojo.*;
import com.zimax.mcrs.warn.mapper.AlarmRuleMapper;
import com.zimax.mcrs.warn.pojo.AlarmRule;
import com.zimax.mcrs.warn.pojo.AlarmRuleVo;
import com.zimax.mcrs.warn.pojo.MonitorEquipment;
import com.zimax.mcrs.warn.pojo.MonitorEquipmentVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 警告规则服务
 *
 * @author 林俊杰
 * @date 2022/11/29
 */
@Service
public class AlarmRuleService {

    @Autowired
    private AlarmRuleMapper alarmRuleMapper;

    /**
     * 查询所有预警规则
     */
    public List<AlarmRuleVo> queryAlarmRule(String page, String limit, String alarmRuleId, String alarmRuleTitle, String enable,
                                            String monitorLevel, String alarmRuleDescribe, String createName, String ruleMakeFormTime,
                                            String updateName, String ruleUpdateTime, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "rul.rule_make_form_time");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("alarmRuleId", alarmRuleId);
        map.put("alarmRuleTitle", alarmRuleTitle);
        map.put("enable", enable);
        map.put("monitorLevel", monitorLevel);
        map.put("alarmRuleDescribe", alarmRuleDescribe);
        map.put("createName", createName);
        map.put("ruleMakeFormTime", ruleMakeFormTime);
        map.put("updateName", updateName);
        map.put("ruleUpdateTime", ruleUpdateTime);
        return alarmRuleMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(String alarmRuleId, String alarmRuleTitle, String enable,
                     String monitorLevel, String alarmRuleDescribe, String createName, String ruleMakeFormTime,
                     String updateName, String ruleUpdateTime) {
        return alarmRuleMapper.count(alarmRuleId, alarmRuleTitle, enable, monitorLevel, alarmRuleDescribe, createName, ruleMakeFormTime,
                updateName,ruleUpdateTime);
    }

    /**
     * 添加预警规则
     *
     * @param alarmRule 预警规则
     */
    public void addAlarmRule(AlarmRule alarmRule) {
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        alarmRule.setRuleMakeFormPeople(userObject.getUserId());
        alarmRule.setRuleMakeFormTime(new Date());
        alarmRuleMapper.addAlarmRule(alarmRule);
        //添加预警规则对应的监控对象
        if (alarmRule.getMonitorEquipmentList().size() > 0) {
            for (MonitorEquipment monitorEquipment : alarmRule.getMonitorEquipmentList()) {
                monitorEquipment.setAlarmRuleInt(alarmRule.getAlarmRuleInt());
                alarmRuleMapper.addMonitorEquipment(monitorEquipment);
            }
        }
    }

    /**
     * 删除预警规则
     *
     * @param alarmRuleInt 预警规则主键
     */
    public void removeAlarmRule(int alarmRuleInt) {
        //从表中获取预警规则的对应监控对象
        List<MonitorEquipment> monitorEquipmentList = alarmRuleMapper.queryMonitorEquipment(alarmRuleInt);
        //如果存在监控对象，删除
        if (monitorEquipmentList.size() > 0) {
            for (MonitorEquipment monitorEquipment : monitorEquipmentList) {
                alarmRuleMapper.removeMonitorEquipment(monitorEquipment.getMonitorEquipmentId());
            }
        }
        alarmRuleMapper.removeAlarmRule(alarmRuleInt);
    }

    /**
     * 修改预警规则
     *
     * @param alarmRule 预警规则
     */
    public void updateAlarmRule(AlarmRule alarmRule) {
        //修改子表顺序，先删除规则对应的监控对象，再从请求中获取修改后的监控对象，重新添加
        //从表中获取预警规则的对应监控对象
        List<MonitorEquipment> monitorEquipmentList = alarmRuleMapper.queryMonitorEquipment(alarmRule.getAlarmRuleInt());
        if (monitorEquipmentList.size() > 0) {
            for (MonitorEquipment monitorEquipment : monitorEquipmentList) {
                alarmRuleMapper.removeMonitorEquipment(monitorEquipment.getMonitorEquipmentId());
            }
        }
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        alarmRule.setRuleUpdatePeople(userObject.getUserId());
        alarmRule.setRuleUpdateTime(new Date());
        alarmRuleMapper.updateAlarmRule(alarmRule);
        //添加预警规则新的对应监控对象
        if (alarmRule.getMonitorEquipmentList().size() > 0) {
            for (MonitorEquipment monitorEquipment : alarmRule.getMonitorEquipmentList()) {
                monitorEquipment.setAlarmRuleInt(alarmRule.getAlarmRuleInt());
                alarmRuleMapper.addMonitorEquipment(monitorEquipment);
            }
        }

    }

    /**
     * 批量删除告警规则
     */
    public void deleteAlarmRules(List<Integer> alarmRuleInt) {

        //从表中获取预警规则的对应监控对象
        for (Integer a : alarmRuleInt) {
            List<MonitorEquipment> monitorEquipmentList = alarmRuleMapper.queryMonitorEquipment(a);
            //如果存在监控对象，删除
            if (monitorEquipmentList.size() > 0) {
                for (MonitorEquipment monitorEquipment : monitorEquipmentList) {
                    alarmRuleMapper.removeMonitorEquipment(monitorEquipment.getMonitorEquipmentId());
                }
            }
        }
        alarmRuleMapper.deleteAlarmRules(alarmRuleInt);
    }

    /**
     * 查询预警规则对应的监控对象
     */
    public AlarmRule getMonitorEquipmentVo(int alarmRuleInt) {
        AlarmRule alarmRule = new AlarmRule();
        List<MonitorEquipmentVo> monitorEquipmentVoList = alarmRuleMapper.queryMonitorEquipmentVo(alarmRuleInt);
        if (monitorEquipmentVoList != null && monitorEquipmentVoList.size() > 0) {
            for (MonitorEquipmentVo monitorEquipmentVo : monitorEquipmentVoList) {
                List<WorkStation> workStationList = alarmRuleMapper.queryWorkStationList(monitorEquipmentVo.getEquipmentInt());
                for (WorkStation workStation : workStationList) {
                    String a = workStation.getWorkStationNum();
                    if (monitorEquipmentVo.getWorkStationList() == null || monitorEquipmentVo.getWorkStationList() == "") {
                        monitorEquipmentVo.setWorkStationList(a);
                    } else {
                        monitorEquipmentVo.setWorkStationList(monitorEquipmentVo.getWorkStationList() + "," + a);
                    }
                }
            }
            alarmRule.setMonitorEquipmentVoList(monitorEquipmentVoList);
        }
        return alarmRule;
    }


    /**
     * 查询当前预警规则编码编码是否已经存在
     */
    public int countAlarmRule(String alarmRuleId,String alarmRuleInt) {
        return alarmRuleMapper.countAlarmRule(alarmRuleId, alarmRuleInt);
    }
}
