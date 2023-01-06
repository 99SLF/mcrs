package com.zimax.mcrs.device.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.mapper.EquipmentMapper;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.device.pojo.EquipmentVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 设备服务
 *
 * @author 林俊杰
 * @date 2022/11/28
 */
@Service
public class EquipmentService {

    @Autowired
    private EquipmentMapper equipmentMapper;

    /**
     * 查询所有
     */
    public List<EquipmentVo> queryEquipments(String limit, String page, String equipmentId, String equipmentName, String processName, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "eqi.create_time");
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
        map.put("processName", processName);
        return equipmentMapper.queryAll(map);
    }

    /**
     * 添加设备信息
     *
     * @param equipment 角色
     */
    public void addEquipment(Equipment equipment) {
        equipmentMapper.addEquipment(equipment);
    }

    /**
     * 根据资源号删除
     *
     * @param equipmentInt 设备号
     */
    public void removeEquipment(int equipmentInt) {
        equipmentMapper.removeEquipment(equipmentInt);
    }

    /**
     * 更新设备
     */
    public void updateEquipment(Equipment equipment) {
        equipmentMapper.updateEquipment(equipment);
    }

    /**
     * 查询记录
     */
    public int count(String equipmentId, String equipmentName ,String equipmentProperties) {
        return equipmentMapper.count(equipmentId, equipmentName ,equipmentProperties);
    }

    /**
     * 批量删除终端
     */
    public void deleteEquipments(List<Integer> equipmentInt) {
        equipmentMapper.deleteEquipments(equipmentInt);
    }

    /**
     * 检测设备资源号是否存在
     *
     * @param equipmentId 设备资源号
     */
    public int checkEquipmentId(String equipmentId) {
        return equipmentMapper.checkEquipmentId(equipmentId);
    }


}
