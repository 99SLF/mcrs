package com.zimax.mcrs.warn.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.pojo.*;
import com.zimax.mcrs.log.pojo.OperationLog;
import com.zimax.mcrs.log.service.OperationLogService;
import com.zimax.mcrs.warn.mapper.AlarmRuleMapper;
import com.zimax.mcrs.warn.pojo.*;
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

    @Autowired
    private OperationLogService operationLogService;

    /**
     * 查询所有预警规则
     */
    public List<AlarmRuleVo> queryAlarmRule(String page, String limit, String alarmRuleId, String alarmRuleTitle, String enable,
                                            String monitorLevel, String alarmRuleDescribe, String createName, String ruleMakeFormTime,
                                            String updateName, String ruleUpdateTime, String order, String field) {
        //判断是否点击了查询按钮
        if (alarmRuleId != null || alarmRuleTitle != null || enable != null || monitorLevel != null || alarmRuleDescribe != null || createName != null || ruleMakeFormTime != null || updateName != null || ruleUpdateTime != null) {
            //传递空对象至方法
            AlarmRule alarmRule = new AlarmRule();
            addOperationLog(alarmRule, 1);
        }
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
                updateName, ruleUpdateTime);
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
        //调用操作日志生成接口，生成日志
        addOperationLog(alarmRule, 2);

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
        //调用方法查询预警规则内容
        AlarmRule alarmRule = alarmRuleMapper.queryAlarmRule(alarmRuleInt);
        //调用操作日志生成方法，生成操作日志
        addOperationLog(alarmRule, 3);

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
        //根据预警规则主键查询修改前的预警规则信息
        AlarmRule alarmRule1 = alarmRuleMapper.queryAlarmRule(alarmRule.getAlarmRuleInt());
        //对于预警规则信息的标题属性，检查是否发生修改
        if (alarmRule.getAlarmRuleTitle().equals(alarmRule1.getAlarmRuleTitle())){
            addOperationLog(alarmRule,4);
        }else {
            //如果标题发生改变，记录修改前后的标题
            addOperationLog(alarmRule,alarmRule1);
        }
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
        //循环遍历删除规则主键
        for (Integer a:alarmRuleInt){
            //使用遍历出的主键查询主键对应的预警规则信息
            AlarmRule alarmRule = alarmRuleMapper.queryAlarmRule(a);
            //将信息传入操作日志生成方法中
            addOperationLog(alarmRule,3);
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
     * 查询当前预警规则编码是否已经存在
     */
    public int countAlarmRule(String alarmRuleId, String alarmRuleInt) {
        return alarmRuleMapper.countAlarmRule(alarmRuleId, alarmRuleInt);
    }


    /**
     * 预警规则生成操作日志
     * 此处生成增，删，部分改，查询日志操作日志
     */
    public void addOperationLog(AlarmRule alarmRule, int a) {
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
                operationLog.setOperationContent("查询预警规则");
                break;
            case 2:
                operationLog.setOperationType("101");
                operationLog.setOperationContent("添加预警规则:" + alarmRule.getAlarmRuleTitle());
                break;
            case 3:
                operationLog.setOperationType("103");
                operationLog.setOperationContent("删除预警规则:" + alarmRule.getAlarmRuleTitle());
                break;
            case 4:
                operationLog.setOperationType("102");
                operationLog.setOperationContent("修改预警规则:" + alarmRule.getAlarmRuleTitle());
                break;
        }
        operationLogService.addOperationLog(operationLog);
    }

    /**
     * 预警规则生成操作日志
     * 此处仅生成修改预警规则名称的操作日志
     * 如果修改规则标题，需要指明修改前的规则，故重写此方法
     */
    public void addOperationLog(AlarmRule alarmRule1, AlarmRule alarmRule2) {
        //获取当前用户信息
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        //创建操作日志对象
        OperationLog operationLog = new OperationLog();
        operationLog.setLogStatus("101");
        operationLog.setResult("101");
        operationLog.setOperationType("102");
        operationLog.setOperationContent("修改预警规则:将预警规则" + alarmRule1.getAlarmRuleTitle() + "的标题修改为" + alarmRule2.getAlarmRuleTitle());
        operationLog.setUser(userObject.getUserId());
        operationLog.setOperationTime(new Date());
        operationLogService.addOperationLog(operationLog);
    }

}
