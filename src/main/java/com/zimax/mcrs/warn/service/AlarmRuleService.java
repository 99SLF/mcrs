package com.zimax.mcrs.warn.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.warn.mapper.AlarmRuleMapper;
import com.zimax.mcrs.warn.pojo.AlarmRule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 警告规则服务
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
    public List<AlarmRule> queryAlarmRule(String  page, String limit, Integer alarmRuleId, String alarmRuleTitle, String monitorLevel, String enable, String alarmEventId, String monitorObject, String ruleMakeFormPeople, String ruleMakeFormTime, String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","rule_make_form_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("alarmRuleId",alarmRuleId);
        map.put("alarmRuleTitle",alarmRuleTitle);
        map.put("monitorLevel",monitorLevel);
        map.put("enable",enable);
        map.put("alarmEventId",alarmEventId);
        map.put("monitorObject",monitorObject);
        map.put("ruleMakeFormPeople",ruleMakeFormPeople);
        map.put("ruleMakeFormTime",ruleMakeFormTime);
        return alarmRuleMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(Integer alarmRuleId, String alarmRuleTitle){
        return alarmRuleMapper.count(alarmRuleId,alarmRuleTitle);
    }

    /**
     * 添加预警规则
     * @param alarmRule 预警规则
     */
    public void addAlarmRule(AlarmRule alarmRule ){
        alarmRuleMapper.addAlarmRule(alarmRule);
    }

    /**
     * 删除预警规则
     * @param  alarmRuleId 预警规则编码
     */
    public void removeAlarmRule(int alarmRuleId){
        alarmRuleMapper.removeAlarmRule(alarmRuleId);
    }

    /**
     * 修改预警规则
     * @param alarmRule 预警规则
     */
    public void updateAlarmRule(AlarmRule alarmRule){
        alarmRuleMapper.updateAlarmRule(alarmRule);

    }
}
