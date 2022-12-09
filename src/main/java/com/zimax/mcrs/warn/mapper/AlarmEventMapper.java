package com.zimax.mcrs.warn.mapper;

import com.zimax.mcrs.warn.pojo.AlarmEvent;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 警告信息操作
 */
@Mapper
public interface AlarmEventMapper {

    /**
     *查询全部预警事件
     */
    List<AlarmEvent> queryAll(Map map);

    /**
     *记录预警事件条数
     * @param alarmEventId 预警事件编码
     * @param alarmEventTitle 预警事件标题
     */
    int count(@Param("alarmEventId") Integer alarmEventId, @Param("alarmEventTitle") String alarmEventTitle);

    /**
     *添加预警事件
     */
    void addAlarmEvent(AlarmEvent alarmEvent);

    /**
     *根据预警事件编号来删除
     */
    void removeAlarmEvent(Integer alarmEventId);

    /**
     *修改预警事件
     */
    void updateAlarmEvent(AlarmEvent alarmEvent);

    /**
     *修改预警事件启用状态
     */
//    void enable(AlarmEvent alarmEvent);
}
