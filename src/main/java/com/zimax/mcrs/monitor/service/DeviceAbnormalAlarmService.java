package com.zimax.mcrs.monitor.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.monitor.mapper.DeviceAbnormalAlarmMapper;
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
                                                      String processName, String alarmEventTitle ,String alarmType,
                                                      String alarmLevel, String alarmEventContent, String occurrenceTime,
                                                      String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();

        if (order == null) {
            map.put("order", "desc");
            map.put("field", "mdr.device_name");
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
        map.put("processName", processName);
        map.put("alarmEventTitle", alarmEventTitle);
        map.put("alarmType", alarmType);
        map.put("alarmLevel", alarmLevel);
        map.put("alarmEventContent", alarmEventContent);
        map.put("occurrenceTime", occurrenceTime);
        return deviceAbnormalAlarmMapper.queryDeviceAbnormalAlarm(map);

    }
    /**
     * 记录数
     * @param
     * @return
     */
    public int countAA(String equipmentId,  String equipmentName, String deviceName,
                       String processName, String alarmEventTitle ,String alarmType,
                       String alarmLevel, String alarmEventContent, String occurrenceTime) {
        return deviceAbnormalAlarmMapper.countAA(equipmentId, equipmentName,deviceName, processName,alarmEventTitle, alarmType, alarmLevel, alarmEventContent, occurrenceTime);
    }
}
