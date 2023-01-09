package com.zimax.mcrs.monitor.mapper;

import com.zimax.mcrs.monitor.pojo.SoftwareRunStatus;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/1/3 15:57
 */

@Mapper
public interface SoftwareRuntimeMapper {

    /**
     * 查询软件运行状态信息
     * @param
     * @return
     */
    List<SoftwareRunStatus> querySoRuntimes(Map map);

    /**
     * 查询软件运行状态记录数
     * @param
     * @return
     */
    int countSO(@Param("equipmentId") String equipmentId, @Param("deviceName") String deviceName,
                @Param("deviceSoType") String deviceSoType, @Param("deviceSoRunStatus") String deviceSoRunStatus
    );

}
