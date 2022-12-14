package com.zimax.mcrs.monitor.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.monitor.pojo.AccessStatus;
import com.zimax.mcrs.monitor.mapper.AccessMonitorMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/12 0:27
 */
@Service
public class AccessMonitorService {
    @Autowired
    private AccessMonitorMapper accessMonitorMapper;
    /**
     * 添加监控信息
     * @param accessStatus 监控信息
     */
    public void addAccessMonitor(AccessStatus accessStatus){

        accessMonitorMapper.addAccessMonitor(accessStatus);
    }

    /**
     * 查询软件运行状态信息
     */
    public List<AccessStatus> querySoRuntimes(String page, String limit,
                                             String equipmentId, String APPId,
                                             String deviceSoType, String deviceSoRuntime,
                                             String order,String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
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
        map.put("deviceSoType", deviceSoType);
        map.put("deviceSoRuntime", deviceSoRuntime);
        return accessMonitorMapper.querySoRuntimes(map);

    }

    public int countSO(String equipmentId, String APPId,
                     String deviceSoType, String deviceSoRuntime) {
        return accessMonitorMapper.countSO(equipmentId, APPId, deviceSoType, deviceSoRuntime);
    }

    /**
     * 查询设备接入信息
     */
    public List<AccessStatus> queryEquipmentAccess(String page, String limit,
                                                   String equipmentId, String accessStatus,
                                                   String antennaStatus,
                                                   String order,String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
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
        map.put("accessStatus", accessStatus);
        map.put("antennaStatus", antennaStatus);
        return accessMonitorMapper.queryEquipmentAccess(map);

    }

    public int countEQ(String equipmentId, String accessStatus,
                       String antennaStatus) {
        return accessMonitorMapper.countEQ(equipmentId, accessStatus, antennaStatus);
    }
}
