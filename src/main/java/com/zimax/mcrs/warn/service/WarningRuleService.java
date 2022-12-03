package com.zimax.mcrs.warn.service;

import com.zimax.mcrs.warn.mapper.WarningRuleMapper;
import com.zimax.mcrs.warn.pojo.WarningRule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 警告规则服务
 * @author 林俊杰
 * @date 2022/11/29
 */
@Service
public class WarningRuleService {

    @Autowired
    private WarningRuleMapper warningRuleMapper;

    /**
     * 添加预警规则
     * @param warningRule 预警规则
     */
    public void addWarningRule(WarningRule warningRule){
        warningRuleMapper.insert(warningRule);
    }

    /**
     * 根绝预警编号删除
     * @param warningRuleId 角色编码
     */
    public void deleteById(int warningRuleId){
        warningRuleMapper.deleteById(warningRuleId);
    }

    /**
     * 更新预警规则
     */
    public void updateWarningRule(WarningRule warningRule){
        warningRuleMapper.updateById(warningRule);
    }

    /**
     * 查询预警规则
     */
    public List<WarningRule> queryAll(){
        return warningRuleMapper.selectList(null);
    }

    /**
     * 根据预警编码查询
     */
    public WarningRule query(String waringMessageName){
        return warningRuleMapper.selectById(waringMessageName);
    }

    /**
     * 查询所有警告规则
     * @return
     */
    public List<WarningRule> queryWarningRule(){
//        QueryWrapper<WarningRule> queryWrapper = new QueryWrapper<>();
//        List<WarningRule> warningRulesList = warningRuleMapper.selectList(queryWrapper);
//        System.out.println(warningRulesList.toString());
        return null;
    }

    /**
     * 警告推送
     * @return
     */
    public void pushWarning(){

    }


}
