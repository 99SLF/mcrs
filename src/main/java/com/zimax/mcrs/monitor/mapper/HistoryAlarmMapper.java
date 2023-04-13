package com.zimax.mcrs.monitor.mapper;




import com.zimax.mcrs.monitor.pojo.vo.MonitorDeviceAlarmVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/4/11 9:30
 */
@Mapper
public interface HistoryAlarmMapper {

    List<MonitorDeviceAlarmVo> queryHistoryAlarm(Map map);


    int count(@Param("equipmentName") String equipmentName, @Param("deviceName") String deviceName,
              @Param("warnType") String warnType,
              @Param("warnGrade") String warnGrade, @Param("startTime") String startTime,
              @Param("endTime") String endTime);

}

