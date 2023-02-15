package com.zimax.mcrs.monitor.mapper;

import com.zimax.mcrs.monitor.pojo.vo.DeviceAbnVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/1/3 15:05
 */

@Mapper
public interface SystemMonitorAlarmMapper {


    /**
     * 查询系统监控告警信息
     * @param
     * @return
     */
    List<DeviceAbnVo> querySystemMonitorAlarm(Map map);

    /**
     * 查询系统监控告警信息记录数
     * @param
     * @return
     */
    int countSys(@Param("warningTitle") String warningTitle, @Param("warningType") String warningType,
                 @Param("warningLevel") String warningLevel, @Param("occurTime") String occurTime
    );

}
