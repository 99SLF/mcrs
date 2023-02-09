package com.zimax.mcrs.basic.logDeleteRule.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.basic.logDeleteRule.mapper.LogDeleteRuleMapper;
import com.zimax.mcrs.basic.logDeleteRule.pojo.LogDeleteRule;
import com.zimax.mcrs.basic.logDeleteRule.pojo.LogDeleteRuleVo;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.DeviceVo;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.log.pojo.OperationLog;
import com.zimax.mcrs.log.service.OperationLogService;
import com.zimax.mcrs.warn.pojo.AlarmRule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 日志删除规则
 *
 * @author 林俊杰
 * @date 2022/12/21
 */
@Service
public class LogDeleteRuleService {

    @Autowired
    private LogDeleteRuleMapper logDeleteRuleMapper;

    @Autowired
    private OperationLogService operationLogService;

    /**
     * 查询所有终端信息
     *
     * @return
     */
    public List<LogDeleteRuleVo> queryLogDeleteRule(String page, String limit, String deleteRuleTitle, String logType, String order, String field) {
        if (deleteRuleTitle!=null ||logType!= null){
            LogDeleteRule logDeleteRule = new LogDeleteRule();
            addOperationLog(logDeleteRule,1);
        }
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "ldr.log_type");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("deleteRuleTitle", deleteRuleTitle);
        map.put("logType", logType);
        return logDeleteRuleMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(String deleteRuleTitle, String logType) {
        return logDeleteRuleMapper.count(deleteRuleTitle, logType);
    }

    /**
     * 更新日志删除规则
     *
     * @param logDeleteRule 日志删除规则
     */
    public void updateLogDeleteRule(LogDeleteRule logDeleteRule) {
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        logDeleteRule.setUpdater(userObject.getUserId());
        logDeleteRule.setUpdateTime(new Date());
        LogDeleteRule logDeleteRule1 = logDeleteRuleMapper.queryLogDeleteRule(logDeleteRule.getRuleDeleteId());
        if (logDeleteRule1.getDeleteRuleTitle().equals(logDeleteRule.getDeleteRuleTitle())){
            addOperationLog(logDeleteRule,2);
        }else {
            addOperationLog(logDeleteRule1,logDeleteRule);
        }
        logDeleteRuleMapper.updateLogDeleteRule(logDeleteRule);
    }

    /**
     * 启用日志删除规则
     */
    public void enable(List<LogDeleteRule> logDeleteRules) {
        LogDeleteRule logDeleteRule = new LogDeleteRule();
        IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
        for (LogDeleteRule i : logDeleteRules) {
            logDeleteRule.setRuleDeleteId(i.getRuleDeleteId());
            logDeleteRule.setEnable("101");
            logDeleteRule.setUpdater(usetObject.getUserId());
            logDeleteRule.setUpdateTime(new Date());
            logDeleteRuleMapper.enable(logDeleteRule);
            addOperationLog(logDeleteRule,2);
        }
    }

    /**
     * 查询启用日志类型的日志删除规则是否存在已启用规则
     */
    public int countLogType(String logType) {
        return logDeleteRuleMapper.checkEnable(logType);
    }

    /**
     * 查询所有日志删除规则
     *
     * @return
     */
    public List<LogDeleteRuleVo> selectLogDeleteRule() {
        Map<String, Object> map = new HashMap<>();
        return logDeleteRuleMapper.selectLogDeleteRule(map);
    }

    /**
     * 日志执行删除
     */
    public void deleteLog(String logType, String deleteTime) {
        logDeleteRuleMapper.deleteLog(logType, deleteTime);
    }


    /**
     * 日志删除规则生成操作日志
     * 但由于日志删除规则不能新增和删除，故只能生成查询与修改操作日志
     */
    public void addOperationLog(LogDeleteRule logDeleteRule, int a) {
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
                operationLog.setOperationContent("查询日志删除规则");
                break;
            case 2:
                operationLog.setOperationType("102");
                operationLog.setOperationContent("修改日志删除规则:" + logDeleteRule.getDeleteRuleTitle());
                break;
        }
        operationLogService.addOperationLog(operationLog);
    }

    /**
     * 日志删除规则生成操作日志
     * 但由于日志删除规则不能新增和删除，故只能生成查询与修改操作日志
     * 如果修改规则标题，需要指明修改前的规则，故重写此方法
     */
    public void addOperationLog(LogDeleteRule logDeleteRule1, LogDeleteRule logDeleteRule2) {
        //获取当前用户信息
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        //创建操作日志对象
        OperationLog operationLog = new OperationLog();
        operationLog.setLogStatus("101");
        operationLog.setResult("101");
        operationLog.setOperationType("102");
        operationLog.setOperationContent("修改日志删除规则:将日志删除规则" + logDeleteRule1.getDeleteRuleTitle() + "的标题修改为" + logDeleteRule2.getDeleteRuleTitle());
        operationLog.setUser(userObject.getUserId());
        operationLog.setOperationTime(new Date());
        operationLogService.addOperationLog(operationLog);
    }


}
