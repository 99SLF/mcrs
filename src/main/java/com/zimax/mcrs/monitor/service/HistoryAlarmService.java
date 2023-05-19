package com.zimax.mcrs.monitor.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.monitor.mapper.HistoryAlarmMapper;
import com.zimax.mcrs.monitor.pojo.vo.MonitorDeviceAlarmVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/4/11 9:30
 */
@Service
public class HistoryAlarmService {

    @Autowired
    private HistoryAlarmMapper historyAlarmMapper;


    public List<MonitorDeviceAlarmVo> queryHistoryAlarm(String page, String limit,
                                                        String equipmentId, String deviceName,
                                                        String warnType, String warnGrade,
                                                        String startTime, String endTime,
                                                        String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "occurrence_time");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId", equipmentId);
        map.put("deviceName", deviceName);
        map.put("warnType", warnType);
        map.put("warnGrade", warnGrade);
        map.put("startTime", startTime);
        map.put("endTime", endTime);
        return historyAlarmMapper.queryHistoryAlarm(map);

    }

    public int count(String equipmentId, String deviceName,
                     String warnType, String warnGrade,
                     String startTime, String endTime) {
        return historyAlarmMapper.count(equipmentId, deviceName,warnType, warnGrade, startTime, endTime);
    }
}
