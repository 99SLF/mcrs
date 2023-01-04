package com.zimax.mcrs.monitor.mapper;

import com.zimax.mcrs.monitor.pojo.DeviceAbn;
import com.zimax.mcrs.monitor.pojo.vo.DeviceAbnVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/1/3 15:25
 */
@Mapper
public interface DeviceAbnormalAlarmMapper {


    /**
     * 查询终端告警信息
     * @param
     * @return
     */
    List<DeviceAbnVo> queryDeviceAbnormalAlarm(Map map);

    /**
     * 终端告警信息记录数
     * @param
     * @return
     */
    int countAA(@Param("equipmentId") String equipmentId, @Param("deviceName") String deviceName,
                @Param("useProcess") String useProcess, @Param("warningType") String warningType,
                @Param("warningLevel") String warningLevel,
                @Param("occurTime") String occurTime
    );
}
