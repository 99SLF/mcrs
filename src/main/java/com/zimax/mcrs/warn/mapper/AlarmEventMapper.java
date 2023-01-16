package com.zimax.mcrs.warn.mapper;

import com.zimax.mcrs.warn.pojo.AlarmEvent;
import com.zimax.mcrs.warn.pojo.AlarmEventVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;
import java.util.Map;

/**
 * 警告信息操作
 * @author 林俊杰
 * @date 2022/11/29
 */
@Mapper
public interface AlarmEventMapper {

    /**
     *查询全部预警事件
     */
    List<AlarmEventVo> queryAll(Map map);

    /**
     *记录预警事件条数
     * @param alarmEventId 预警事件编码
     * @param alarmEventTitle 预警事件标题
     */
    int count(@Param("alarmEventId") String alarmEventId,
              @Param("alarmEventTitle") String alarmEventTitle,
              @Param("alarmLevel") String alarmLevel,
              @Param("alarmCategory") String alarmCategory,
              @Param("alarmType") String alarmType,
              @Param("createName") String createName,
              @Param("makeFormTime") String makeFormTime);

    /**
     *添加预警事件
     */
    void addAlarmEvent(AlarmEvent alarmEvent);

    /**
     *根据预警事件编号来删除
     */
    void removeAlarmEvent(int alarmEventInt);

    /**
     *修改预警事件
     */
    void updateAlarmEvent(AlarmEvent alarmEvent);

    /**
     *修改预警事件启用状态
     */
//    void enable(AlarmEvent alarmEvent);

    /**
     * 批量删除
     * @param alarmEventInts
     */
    void deleteAlarmEvents(List<Integer> alarmEventInts);

    /**
     * 批量启用
     */
    int enable(AlarmEvent alarmEvent);

    /**
     * 判断当前输入的预警时间编码是否已存在
     */
    int checkAlarmEvent(@Param("alarmEventId") String alarmEventId);
}
