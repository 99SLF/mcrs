package com.zimax.mcrs.basic.logDeleteRule.service;

import com.zimax.mcrs.basic.logDeleteRule.mapper.LogDeleteRuleMapper;
import com.zimax.mcrs.basic.logDeleteRule.pojo.LogDeleteRule;
import com.zimax.mcrs.basic.logDeleteRule.pojo.LogDeleteRuleVo;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.DeviceVo;
import com.zimax.mcrs.device.pojo.Equipment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 日志删除规则
 * @author 林俊杰
 * @date 2022/12/21
 */
@Service
public class LogDeleteRuleService {

    @Autowired
    private LogDeleteRuleMapper logDeleteRuleMapper;

    /**
     * 查询所有终端信息
     * @return
     */
    public List<LogDeleteRuleVo> queryLogDeleteRule(String  page, String limit, String deleteRuleNum, String deleteRuleTitle, String ruleLevel, String deleteRuleType, String creator,String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","create_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("deleteRuleNum",deleteRuleNum);
        map.put("deleteRuleTitle",deleteRuleTitle);
        map.put("ruleLevel",ruleLevel);
        map.put("deleteRuleType",deleteRuleType);
        map.put("creator",creator);
        return logDeleteRuleMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(String deleteRuleNum){
        return logDeleteRuleMapper.count(deleteRuleNum);
    }


    /**
     * 添加日志删除规则
     */
    public void addLogDeleteRule(LogDeleteRule logDeleteRule){
        logDeleteRuleMapper.addLogDeleteRule(logDeleteRule);
    }

    /**
     * 删除日志删除规则
     * @param ruleDeleteId 日志删除规则主键
     */
    public void removeLogDeleteRule(int ruleDeleteId) {
        logDeleteRuleMapper.removeLogDeleteRule(ruleDeleteId);
    }

    /**
     * 更新日志删除规则
     *
     * @param logDeleteRule 日志删除规则
     */
    public void updateLogDeleteRule(LogDeleteRule logDeleteRule) {
        logDeleteRuleMapper.updateLogDeleteRule(logDeleteRule);
    }

    /**
     * 批量删除日志删除规则
     */
    public void deleteLogDeleteRules(List<Integer> ruleDeleteId) {
        logDeleteRuleMapper.deleteLogDeleteRules(ruleDeleteId);
    }


    /**
     * 检测删除规则是否存在
     *
     * @param deleteRuleNum 日志删除规则编码
     */
    public int  checkLogDeleteRule(String deleteRuleNum) {
        return logDeleteRuleMapper.checkLogDeleteRule(deleteRuleNum) ;
    }


    /**
     * 批量启用日志删除规则
     */
    public void enable(List<Integer> ruleDeleteId) {
        logDeleteRuleMapper.enable(ruleDeleteId);
    }
}
