package com.zimax.mcrs.warn.service;

import com.zimax.mcrs.warn.mapper.AlarmEventMapper;
import com.zimax.mcrs.warn.mapper.AlarmRuleMapper;
import com.zimax.mcrs.warn.pojo.AlarmEvent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 警告信息服务
 * @author 林俊杰
 * @date 2022/11/29
 */
@Service
public class AlarmEventService {

    @Autowired
    private AlarmEventMapper alarmEventMapper;

    /**
     * 初始化查询
     */
    public AlarmEvent queryAll(){
        return null;
    }

    /**
     * 根据条件查询
     */
    public AlarmEvent query(){
        return null;
    }

    /**
     * 新增告警事件
     * @param alarmEvent 告警事件
     */
    public void addAlarm(AlarmEvent alarmEvent){

    }

    /**
     * 设置启用停用状态
     * @param alarmEventId 告警编码
     */
    public void setEnableStatus(int alarmEventId){

    }

    /**
     * 删除告警事件
     * @param alarmEventId 告警编码
     */
    public void removeAlarm(int alarmEventId){

    }

    /**
     * 修改告警事件
     * @param alarmEventId 告警编码
     */
    public void updateAlarm(int alarmEventId){

    }

}
