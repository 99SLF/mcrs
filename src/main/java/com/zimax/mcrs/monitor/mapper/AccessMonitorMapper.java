package com.zimax.mcrs.monitor.mapper;

import com.zimax.mcrs.monitor.pojo.AccessStatus;
import com.zimax.mcrs.report.pojo.AbnProdPrcs;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/12 0:32
 */
@Mapper
public interface AccessMonitorMapper {
    /**
     * 添加监控信息
     * @param accessStatus 监控信息
     * @return
     */
    void addAccessMonitor(AccessStatus accessStatus);

    /**
     * 查询软件运行状态信息
     * @param
     * @return
     */
    List<AccessStatus> querySoRuntimes(Map map);

    /**
     * 查询软件运行状态记录数
     * @param
     * @return
     */
    int countSO(@Param("equipmentId") String equipmentId, @Param("APPId") String APPId,
              @Param("deviceSoType") String deviceSoType, @Param("deviceSoRuntime") String deviceSoRuntime
    );

    /**
     * 查询设备接入信息
     * @param
     * @return
     */
    List<AccessStatus> queryEquipmentAccess(Map map);

    /**
     * 查询软设备接入记录数
     * @param
     * @return
     */
    int countEQ(@Param("equipmentId") String equipmentId, @Param("accessStatus") String accessStatus,
                @Param("antennaStatus") String antennaStatus
    );
}
