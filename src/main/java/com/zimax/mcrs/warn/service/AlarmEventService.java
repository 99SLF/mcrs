package com.zimax.mcrs.warn.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.warn.mapper.AlarmEventMapper;
import com.zimax.mcrs.warn.mapper.AlarmRuleMapper;
import com.zimax.mcrs.warn.pojo.AlarmEvent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
     * 查询全部预警信息
     */
    public List<AlarmEvent> queryAll(String page, String limit, Integer alarmEventId, String alarmEventTitle, String alarmLevel, String alarmCategory, String alarmType, String makeFormPeople, String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "make_form_time");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("alarmEventId", alarmEventId);
        map.put("alarmEventTitle", alarmEventTitle);
        map.put("alarmLevel", alarmLevel);
        map.put("alarmCategory", alarmCategory);
        map.put("alarmType", alarmType);
        map.put("makeFormPeople", makeFormPeople);
        return alarmEventMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(Integer alarmEventId, String alarmEventTitle) {
        return alarmEventMapper.count(alarmEventId, alarmEventTitle);
    }


    /**
     * 新增预警事件事件
     * @param alarmEvent 告警事件
     */
    public void addAlarm(AlarmEvent alarmEvent){
        alarmEventMapper.addAlarmEvent(alarmEvent);
    }

    /**
     * 删除预警事件
     * @param alarmEventInt 告警主键
     */
    public void removeAlarm(Integer alarmEventInt){
        alarmEventMapper.removeAlarmEvent(alarmEventInt);

    }

    /**
     * 修改告警事件
     */
    public void updateAlarm(AlarmEvent alarmEvent){
        alarmEventMapper.updateAlarmEvent(alarmEvent);
    }

    /**
     * 修改启用状态
     */
//    public  void enableAlarm(AlarmEvent alarmEvent){
//        alarmEventMapper.enable(alarmEvent);
//    }

    /**
     * 批量删除告警事件
     */
    public void deleteAlarmEvents(List<Integer> alarmEventInt) {
        alarmEventMapper.deleteAlarmEvents(alarmEventInt);
    }

}
