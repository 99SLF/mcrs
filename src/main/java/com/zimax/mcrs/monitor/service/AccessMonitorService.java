package com.zimax.mcrs.monitor.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.monitor.pojo.AccessStatus;
import com.zimax.mcrs.monitor.mapper.AccessMonitorMapper;
import com.zimax.mcrs.monitor.pojo.vo.AccessStatusVo;
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
     * 查询PLC设备接入信息
     */
    public List<AccessStatus> queryEquipmentAccessP(String page, String limit,
                                                   String equipmentId, String accessStatus,
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
        return accessMonitorMapper.queryEquipmentAccessP(map);

    }
    /**
     * 记录数
     * @param
     * @return
     */
    public int countEQP(String equipmentId, String accessStatus) {
        return accessMonitorMapper.countEQP(equipmentId, accessStatus);
    }


    /**
     * 查询RFID设备接入信息
     */
    public List<AccessStatus> queryEquipmentAccessR(String page, String limit,
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
        return accessMonitorMapper.queryEquipmentAccessR(map);

    }
    /**
     * 记录数
     * @param
     * @return
     */
    public int countEQR(String equipmentId, String accessStatus,
                        String antennaStatus) {
        return accessMonitorMapper.countEQR(equipmentId, accessStatus, antennaStatus);
    }


    /**
     * 分页查询终端告警信息状态
     */
    public List<AccessStatus> queryDeviceAbnormalAlarm(String page, String limit,
                                                       String equipmentId, String warningTitle,
                                                       String warningType, String warningLevel,
                                                       String occurTime,
                                                       String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();

        if (order == null) {
            map.put("order", "desc");
            map.put("field", "occur_time");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId", equipmentId);
        map.put("warningTitle", warningTitle);
        map.put("warningType", warningType);
        map.put("warningLevel", warningLevel);
        map.put("occurTime", occurTime);
        return accessMonitorMapper.queryDeviceAbnormalAlarm(map);

    }
    /**
     * 记录数
     * @param
     * @return
     */
    public int countAA(String equipmentId, String warningTitle,
                       String warningType, String warningLevel,
                       String occurTime) {
        return accessMonitorMapper.countAA(equipmentId, warningTitle, warningType, warningLevel,occurTime);
    }

    /**
     * 分页查询系统监测预警
     */
    public List<AccessStatus> querySystemMonitorAlarm(String page, String limit,
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
        return accessMonitorMapper.querySystemMonitorAlarm(map);

    }
    /**
     * 记录数
     * @param
     * @return
     */
    public int countSys( String warningTitle, String warningType,
                         String warningLevel, String occurTime) {
        return accessMonitorMapper.countSys(warningTitle, warningType, warningLevel, occurTime);
    }

    /**
     * 查询终端运行状态信息
     */
    public List<AccessStatusVo> queryDeviceRuntime(String page, String limit,
                                                   String equipmentId, String APPId,
                                                   String deviceSoType, String deviceSoRuntime,
                                                   String order, String field) {
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
        return accessMonitorMapper.queryDeviceRuntime(map);

    }

    public int countDR(String equipmentId, String APPId,
                       String deviceSoType, String deviceSoRuntime) {
        return accessMonitorMapper.countDR(equipmentId, APPId, deviceSoType, deviceSoRuntime);
    }



}
