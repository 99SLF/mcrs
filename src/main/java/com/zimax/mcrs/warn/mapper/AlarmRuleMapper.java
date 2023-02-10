package com.zimax.mcrs.warn.mapper;

import com.zimax.mcrs.device.pojo.WorkStation;
import com.zimax.mcrs.warn.pojo.*;
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
    List<AlarmRuleVo> queryAll(Map map);

    /**
     *记录预警事件条数
     * @param alarmRuleId 预警规则编码
     * @param alarmRuleTitle 预警规则标题
     */
    int count(@Param("alarmRuleId") String alarmRuleId,
              @Param("alarmRuleTitle") String alarmRuleTitle,
              @Param("enable")  String enable,
              @Param("monitorLevel") String monitorLevel,
              @Param("alarmRuleDescribe")String alarmRuleDescribe,
              @Param("createName") String createName,
              @Param("ruleMakeFormTime")String ruleMakeFormTime,
              @Param("updateName")String updateName,
              @Param("ruleUpdateTime")String ruleUpdateTime);

    /**
     *添加预警事件
     */
    void addAlarmRule(AlarmRule alarmRule);

    /**
     *依据主键删除预警事件
     */
    void removeAlarmRule(int alarmRuleInt);

    /**
     *修改预警事件
     */
    void updateAlarmRule(AlarmRule alarmRule);

    /**
     * 批量删除
     * @param alarmRuleInt
     */
    void deleteAlarmRules(List<Integer> alarmRuleInt);


    /**
     *查询预警规则对应的监控对象
     */
    List<MonitorEquipmentVo> queryMonitorEquipmentVo(int alarmRuleInt);

    /**
     *查询预警规则对应的监控对象
     */
    List<MonitorEquipment> queryMonitorEquipment(int alarmRuleInt);

    /**
     *查询预警规则对应的监控对象
     */
    List<WorkStation> queryWorkStationList(int equipmentInt);

    /**
     *添加预警规则对应的监控对象
     */
    void addMonitorEquipment (MonitorEquipment monitorEquipment);

    /**
     *删除预警规则对应的监控对象
     */
    void removeMonitorEquipment(int monitorEquipmentId);

    /**
     * 根据预警规则编码查询预警规则是否存在
     */
    int countAlarmRule(@Param("alarmRuleId") String alarmRuleId,@Param("alarmRuleInt") String alarmRuleInt);

    /**
     * 根据预警事件主键查询预警事件信息
     */
    AlarmRule queryAlarmRule(int alarmRuleInt);


}
