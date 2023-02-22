package com.zimax.mcrs.monitor.service;

import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.monitor.mapper.EquipmentRuntimeMapper;
import com.zimax.mcrs.monitor.pojo.vo.EquipmentStatusVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/1/3 15:42
 */
@Service
public class EquipmentRuntimeService {

@Autowired
private EquipmentRuntimeMapper equipmentRuntimeMapper;

    /**
     * 查询PLC设备接入信息
     */
    public List<EquipmentStatusVo> queryEquipmentAccessP(String page, String limit,
                                                         String equipmentId, String accessStatus,
                                                         String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();

        if (order == null) {
            map.put("order", "desc");
            map.put("field", "equ.equipment_id");
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
        return equipmentRuntimeMapper.queryEquipmentAccessP(map);

    }
    /**
     * 记录数
     * @param
     * @return
     */
    public int countEQP(String equipmentId, String accessStatus) {
        return equipmentRuntimeMapper.countEQP(equipmentId, accessStatus);
    }


    /**
     * 查询RFID设备接入信息
     */
    public List<EquipmentStatusVo> queryEquipmentAccessR(String page, String limit,
                                                    String equipmentId, String accessStatus,
                                                    String antennaStatus,
                                                    String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();

        if (order == null) {
            map.put("order", "desc");
            map.put("field", "equ.equipment_id");
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
        return equipmentRuntimeMapper.queryEquipmentAccessR(map);

    }
    /**
     * 记录数
     * @param
     * @return
     */
    public int countEQR(String equipmentId, String accessStatus,
                        String antennaStatus) {
        return equipmentRuntimeMapper.countEQR(equipmentId, accessStatus, antennaStatus);
    }

    public List<Equipment> findEquipmentId(String appId) {
        return equipmentRuntimeMapper.findEquipmentId(appId);

    }


}
