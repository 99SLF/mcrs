package com.zimax.mcrs.warn.mapper;

import com.zimax.mcrs.warn.pojo.AlarmEvent;
import com.zimax.mcrs.warn.pojo.AlarmRule;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 *  警告规则操作
 * @author 林俊杰
 * @date 2022/11/29
 */
@Mapper
public interface AlarmRuleMapper {

    /**
     *查询全部预警事件
     */
    List<AlarmRule> queryAll(Map map);

    /**
     *记录预警事件条数
     * @param alarmRuleId 预警规则编码
     * @param alarmRuleTitle 预警规则标题
     */
    int count(@Param("alarmRuleId") Integer alarmRuleId, @Param("alarmRuleTitle") String alarmRuleTitle);

    /**
     *添加预警事件
     */
    void addAlarmRule(AlarmRule alarmRule);

    /**
     *依据主键删除预警事件
     */
    void removeAlarmRule(int alarmRuleId);

    /**
     *修改预警事件
     */
    void updateAlarmRule(AlarmRule alarmRule);

}
