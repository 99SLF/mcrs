package com.zimax.mcrs.warn.service;

import com.zimax.mcrs.warn.mapper.AlarmRuleMapper;
import com.zimax.mcrs.warn.pojo.AlarmRule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
     * 初始化查询
     */
    public List<AlarmRule> queryAll(){
        return null;
    }

    /**
     * 依据条件查询
     */
    public List<AlarmRule> select(){
        return null;
    }

    /**
     * 添加预警规则
     * @param alarmRule 预警规则
     */
    public void addAlarmRule(AlarmRule alarmRule ){

    }

    /**
     * 删除预警规则
     * @param  alarmRuleId 预警规则编码
     */
    public void deleteAlarmRule(int alarmRuleId){

    }


    /**
     * 修改预警规则
     * @param alarmRuleId 预警规则编码
     */
    public void updateAlarmRule(int alarmRuleId){

    }
}
