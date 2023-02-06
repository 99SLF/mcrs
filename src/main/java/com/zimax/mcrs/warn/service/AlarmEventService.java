package com.zimax.mcrs.warn.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.basic.logDeleteRule.pojo.LogDeleteRule;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.warn.mapper.AlarmEventMapper;
import com.zimax.mcrs.warn.mapper.AlarmRuleMapper;
import com.zimax.mcrs.warn.pojo.AlarmEvent;
import com.zimax.mcrs.warn.pojo.AlarmEventVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
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
    public List<AlarmEventVo> queryAll(String page, String limit, String alarmEventId, String alarmEventTitle, String enableStatus, String alarmLevel,
                                       String alarmType, String createName, String makeFormTime,String updateName, String updateTime, String order, String field){
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
        map.put("enableStatus", enableStatus);
        map.put("alarmLevel", alarmLevel);
        map.put("alarmType", alarmType);
        map.put("createName", createName);
        map.put("makeFormTime", makeFormTime);
        map.put("updateName", updateName);
        map.put("updateTime", updateTime);
        return alarmEventMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(String alarmEventId, String alarmEventTitle, String enableStatus, String alarmLevel,
                     String alarmType, String createName, String makeFormTime,String updateName, String updateTime) {
        return alarmEventMapper.count(alarmEventId, alarmEventTitle,enableStatus,alarmLevel,alarmType,createName,makeFormTime,updateName,updateTime);
    }


    /**
     * 新增预警事件事件
     * @param alarmEvent 告警事件
     */
    public void addAlarm(AlarmEvent alarmEvent){
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        alarmEvent.setMakeFormPeople(userObject.getUserId());
        alarmEvent.setMakeFormTime(new Date());
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
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        alarmEvent.setUpdatePeople(userObject.getUserId());
        alarmEvent.setUpdateTime(new Date());
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


    /**
     * 批量启用告警事件
     */
    public void enable(List<Integer> alarmEventInt) {
        AlarmEvent alarmEvent = new AlarmEvent();
        IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
        for (Integer integer:alarmEventInt){
            alarmEvent.setAlarmEventInt(integer);
            alarmEvent.setEnableStatus("101");
            alarmEvent.setUpdatePeople(usetObject.getUserId());
            alarmEvent.setUpdateTime(new Date());
            alarmEventMapper.enable(alarmEvent);
        }
    }

    /**
     * 判断当前预警事件编码是否已存在
     */
    public int checkAlarmEvent(String alarmEventId){
        return alarmEventMapper.checkAlarmEvent(alarmEventId);
    }


}
