package com.zimax.mcrs.device.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.mapper.EquipmentMapper;
import com.zimax.mcrs.device.pojo.Equipment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 设备服务
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
    public List<Equipment> queryEquipments(int limit, int page, String equipmentId, String equipmentName, String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","create_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        map.put("begin",limit*(page-1));
        map.put("limit",limit);
        map.put("equipmentId",equipmentId);
        map.put("equipmentName",equipmentName);
        return equipmentMapper.queryAll(map);
    }

    /**
     * 添加设备信息
     * @param equipment 角色
     */
    public void addEquipment(Equipment equipment){
        equipmentMapper.addEquipment(equipment);
    }

    /**
     * 根据资源号删除
     * @param equipmentId 设备资源号
     */
    public void removeEquipment(String equipmentId){
        equipmentMapper.removeEquipment(equipmentId);
    }

    /**
     * 更新设备
     */
    public void updateEquipment(Equipment equipment){
        equipmentMapper.updateEquipment(equipment);
    }

    /**
     * 查询记录
     */
    public int count(String equipmentId, String equipmentName){
        return equipmentMapper.count(equipmentId,equipmentName);
    }




}
