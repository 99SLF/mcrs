package com.zimax.mcrs.monitor.mapper;

import com.zimax.mcrs.monitor.pojo.vo.DeviceMonitorInfoVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/1/3 16:09
 */
@Mapper
public interface DeviceRuntimeMapper {

    /**
     * 查询终端运行状态信息
     * @param
     * @return
     */
    List<DeviceMonitorInfoVo> queryDeviceRuntime(Map map);

    /**
     * 查询终端运行状态记录数
     * @param
     * @return
     */
    int countDR(@Param("equipmentId") String equipmentId, @Param("APPId") String APPId,
                @Param("deviceSoftwareType") String deviceSoftwareType, @Param("deviceSoRunStatus") String deviceSoRunStatus
    );

}
