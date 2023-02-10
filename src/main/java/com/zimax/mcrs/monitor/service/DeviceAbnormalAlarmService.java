package com.zimax.mcrs.monitor.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.monitor.mapper.DeviceAbnormalAlarmMapper;
import com.zimax.mcrs.monitor.pojo.DeviceAbn;
import com.zimax.mcrs.monitor.pojo.vo.DeviceAbnVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/1/3 15:26
 */
@Service
public class DeviceAbnormalAlarmService {


    @Autowired
    private DeviceAbnormalAlarmMapper deviceAbnormalAlarmMapper;

    /**
     * 分页查询终端告警信息状态
     */
    public List<DeviceAbnVo> queryDeviceAbnormalAlarm(String page, String limit,
                                                      String equipmentId,  String equipmentName, String deviceName,
                                                      String useProcess, String warningTitle ,String warningType,
                                                      String warningLevel, String warningContent, String occurTime,
                                                      String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();

        if (order == null) {
            map.put("order", "desc");
            map.put("field", "a.create_time");
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
        map.put("useProcess", useProcess);
        map.put("warningType", warningType);
        map.put("warningTitle", warningTitle);
        map.put("warningLevel", warningLevel);
        map.put("warningContent", warningContent);
        map.put("occurTime", occurTime);
        return deviceAbnormalAlarmMapper.queryDeviceAbnormalAlarm(map);

    }
    /**
     * 记录数
     * @param
     * @return
     */
    public int countAA(String equipmentId,  String equipmentName, String deviceName,
                       String useProcess, String warningTitle ,String warningType,
                       String warningLevel, String warningContent, String occurTime) {
        return deviceAbnormalAlarmMapper.countAA(equipmentId,equipmentName, deviceName, useProcess,warningTitle, warningType,warningLevel,warningContent, occurTime);
    }
}
