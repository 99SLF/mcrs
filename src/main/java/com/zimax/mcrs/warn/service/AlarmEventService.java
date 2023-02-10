package com.zimax.mcrs.warn.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.log.pojo.OperationLog;
import com.zimax.mcrs.log.service.OperationLogService;
import com.zimax.mcrs.warn.mapper.AlarmEventMapper;
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
 *
 * @author 林俊杰
 * @date 2022/11/29
 */
@Service
public class AlarmEventService {

    @Autowired
    private AlarmEventMapper alarmEventMapper;

    @Autowired
    private OperationLogService operationLogService;

    /**
     * 查询全部预警信息
     */
    public List<AlarmEventVo> queryAll(String page, String limit, String alarmEventId, String alarmEventTitle, String enableStatus, String alarmLevel,
                                       String alarmType, String createName, String makeFormTime, String updateName, String updateTime, String order, String field) {
        if (alarmEventId != null || alarmEventTitle != null || enableStatus != null || alarmLevel != null || alarmType != null || createName != null || makeFormTime != null || updateName != null || updateTime != null) {
            AlarmEvent alarmEvent = new AlarmEvent();
            addOperationLog(alarmEvent, 1);
        }
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
     * 查询记录数
     */
    public int count(String alarmEventId, String alarmEventTitle, String enableStatus, String alarmLevel,
                     String alarmType, String createName, String makeFormTime, String updateName, String updateTime) {
        return alarmEventMapper.count(alarmEventId, alarmEventTitle, enableStatus, alarmLevel, alarmType, createName, makeFormTime, updateName, updateTime);
    }


    /**
     * 新增预警事件事件
     *
     * @param alarmEvent 告警事件
     */
    public void addAlarm(AlarmEvent alarmEvent) {
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        alarmEvent.setMakeFormPeople(userObject.getUserId());
        alarmEvent.setMakeFormTime(new Date());
        alarmEventMapper.addAlarmEvent(alarmEvent);
        //调用日志生成方法生成此次操作的日志
        addOperationLog(alarmEvent,2);
    }

    /**
     * 删除预警事件
     *
     * @param alarmEventInt 告警主键
     */
    public void removeAlarm(Integer alarmEventInt) {
        //根据预警事件的主键查询被删除的预警事件信息
        AlarmEvent alarmEvent = alarmEventMapper.queryAlarmEvent(alarmEventInt);
        //调用日志生成方法生成此次操作的日志
        addOperationLog(alarmEvent,3);
        alarmEventMapper.removeAlarmEvent(alarmEventInt);

    }

    /**
     * 修改告警事件
     */
    public void updateAlarm(AlarmEvent alarmEvent) {
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        alarmEvent.setUpdatePeople(userObject.getUserId());
        alarmEvent.setUpdateTime(new Date());
        //根据预警事件的主键查询被删除的预警事件信息
        AlarmEvent alarmEvent1 = alarmEventMapper.queryAlarmEvent(alarmEvent.getAlarmEventInt());
        //如果预警标题没有发生修改，则显示修改了预警标题的信息，如果预警标题发生修改，则显示修改前后的预警标题
        //调用日志生成方法生成此次操作的日志
        if (alarmEvent.getAlarmEventTitle().equals(alarmEvent1.getAlarmEventTitle())){
            addOperationLog(alarmEvent,4);
        }else {
            addOperationLog(alarmEvent1,alarmEvent);
        }
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
        for (Integer a:alarmEventInt){
            AlarmEvent alarmEvent = alarmEventMapper.queryAlarmEvent(a);
            addOperationLog(alarmEvent,3);
        }
        alarmEventMapper.deleteAlarmEvents(alarmEventInt);
    }


    /**
     * 批量启用告警事件
     */
    public void enable(List<Integer> alarmEventInt) {
        AlarmEvent alarmEvent = new AlarmEvent();
        IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
        for (Integer integer : alarmEventInt) {
            alarmEvent.setAlarmEventInt(integer);
            alarmEvent.setEnableStatus("101");
            alarmEvent.setUpdatePeople(usetObject.getUserId());
            alarmEvent.setUpdateTime(new Date());
            alarmEventMapper.enable(alarmEvent);
            addOperationLog(alarmEvent,4);
        }
    }

    /**
     * 判断当前预警事件编码是否已存在
     */
    public int checkAlarmEvent(String alarmEventId, String alarmEventInt) {
        return alarmEventMapper.checkAlarmEvent(alarmEventId, alarmEventInt);
    }

    /**
     * 预警事件生成操作日志
     * 此处生成增，删，部分改，查询日志操作日志
     */
    public void addOperationLog(AlarmEvent alarmEvent, int a) {
        //获取当前用户信息
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        //创建操作日志对象
        OperationLog operationLog = new OperationLog();
        operationLog.setLogStatus("101");
        operationLog.setResult("101");
        operationLog.setUser(userObject.getUserId());
        operationLog.setOperationTime(new Date());
        switch (a) {
            case 1:
                operationLog.setOperationType("104");
                operationLog.setOperationContent("查询预警事件");
                break;
            case 2:
                operationLog.setOperationType("101");
                operationLog.setOperationContent("添加预警事件:" + alarmEvent.getAlarmEventTitle());
                break;
            case 3:
                operationLog.setOperationType("103");
                operationLog.setOperationContent("删除预警事件:" + alarmEvent.getAlarmEventTitle());
                break;
            case 4:
                operationLog.setOperationType("102");
                operationLog.setOperationContent("修改预警事件:" + alarmEvent.getAlarmEventTitle());
                break;
        }
        operationLogService.addOperationLog(operationLog);
    }


    /**
     * 预警事件生成操作日志
     * 此处仅生成修改预警事件名称的操作日志
     * 如果修改设备名称，需要指明修改前的设备，故重写此方法
     */
    public void addOperationLog(AlarmEvent alarmEvent1, AlarmEvent alarmEvent2) {
        //获取当前用户信息
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        //创建操作日志对象
        OperationLog operationLog = new OperationLog();
        operationLog.setLogStatus("101");
        operationLog.setResult("101");
        operationLog.setOperationType("102");
        operationLog.setOperationContent("修改预警事件:将预警事件" + alarmEvent1.getAlarmEventTitle() + "的标题修改为" + alarmEvent2.getAlarmEventTitle());
        operationLog.setUser(userObject.getUserId());
        operationLog.setOperationTime(new Date());
        operationLogService.addOperationLog(operationLog);
    }


}
