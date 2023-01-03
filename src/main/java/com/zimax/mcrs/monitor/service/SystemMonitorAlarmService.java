package com.zimax.mcrs.monitor.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.monitor.mapper.SystemMonitorAlarmMapper;
import com.zimax.mcrs.monitor.pojo.vo.DeviceAbnVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/1/3 15:06
 */

@Service
public class SystemMonitorAlarmService {

    @Autowired
    private SystemMonitorAlarmMapper systemMonitorAlarmMapper;





    /**
     * 分页查询系统监测预警
     */
    public List<DeviceAbnVo> querySystemMonitorAlarm(String page, String limit,
                                                     String warningTitle, String warningType,
                                                     String warningLevel, String occurTime,
                                                     String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();

        if (order == null) {
            map.put("order", "desc");
            map.put("field", "warning_title");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId", warningTitle);
        map.put("warningTitle", warningTitle);
        map.put("warningType", warningType);
        map.put("warningLevel", warningLevel);
        map.put("occurTime", occurTime);
        return systemMonitorAlarmMapper.querySystemMonitorAlarm(map);

    }
    /**
     * 记录数
     * @param
     * @return
     */
    public int countSys( String warningTitle, String warningType,
                         String warningLevel, String occurTime) {
        return systemMonitorAlarmMapper.countSys(warningTitle, warningType, warningLevel, occurTime);
    }
}
