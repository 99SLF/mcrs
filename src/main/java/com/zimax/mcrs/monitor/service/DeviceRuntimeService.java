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
    public List<DeviceMonitorInfoVo> queryDeviceRuntime(String page, String limit,
                                                        String equipmentId, String APPId,
                                                        String deviceSoftwareType, String deviceSoRunStatus,
                                                        String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "equipment_id");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId", equipmentId);
        map.put("APPId", APPId);
        map.put("deviceSoftwareType", deviceSoftwareType);
        map.put("deviceSoRunStatus", deviceSoRunStatus);
        return deviceRuntimeMapper.queryDeviceRuntime(map);

    }

    public int countDR(String equipmentId, String APPId,
                       String deviceSoftwareType, String deviceSoRunStatus) {
        return deviceRuntimeMapper.countDR(equipmentId, APPId, deviceSoftwareType, deviceSoRunStatus);
    }

}
