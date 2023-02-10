package com.zimax.mcrs.monitor.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.monitor.mapper.DeviceRuntimeMapper;
import com.zimax.mcrs.monitor.pojo.vo.DeviceMonitorInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/1/3 16:10
 */

@Service
public class DeviceRuntimeService {

    @Autowired
    private DeviceRuntimeMapper deviceRuntimeMapper;


    /**
     * 查询终端运行状态信息
     */
    public List<DeviceMonitorInfoVo> queryDeviceRuntime( String page, String limit,
                                                         String equipmentId, String equipmentName,
                                                         String deviceName, String deviceSoftwareType,
                                                         String deviceSoRunStatus, String accessStatus,
                                                         String cpuRate, String storageRate,
                                                         String errorRate,
                                                         String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "b.equipment_id");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId", equipmentId);
        map.put("equipmentName", equipmentName);
        map.put("deviceName", deviceName);
        map.put("deviceSoftwareType", deviceSoftwareType);
        map.put("deviceSoRunStatus", deviceSoRunStatus);
        map.put("accessStatus", accessStatus);
        map.put("cpuRate", cpuRate);
        map.put("storageRate", storageRate);
        map.put("errorRate", errorRate);

        return deviceRuntimeMapper.queryDeviceRuntime(map);

    }

    public int countDR(String equipmentId, String equipmentName,
                       String deviceName, String deviceSoftwareType,
                       String deviceSoRunStatus, String accessStatus,
                       String cpuRate, String storageRate,
                       String errorRate) {
        return deviceRuntimeMapper.countDR(equipmentId,  equipmentName, deviceName,  deviceSoftwareType, deviceSoRunStatus,  accessStatus, cpuRate,  storageRate, errorRate);
    }

}
