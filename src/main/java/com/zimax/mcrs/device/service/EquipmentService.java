package com.zimax.mcrs.device.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.mapper.EquipmentMapper;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.device.pojo.EquipmentVo;
import com.zimax.mcrs.device.pojo.WorkStation;
import com.zimax.mcrs.warn.pojo.MonitorEquipment;
import com.zimax.mcrs.warn.pojo.MonitorEquipmentVo;
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
    public List<EquipmentVo> queryEquipments(String limit, String page, String equipmentId, String equipmentName,String enable, String processName, String order, String field) {
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
        map.put("enable", enable);
        map.put("processName", processName);
        return equipmentMapper.queryAll(map);
    }

    /**
     * 添加设备信息
     *
     * @param equipment 角色
     */
    public void addEquipment(Equipment equipment) {
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        equipment.setCreator(userObject.getUserId());
        equipment.setCreateTime(new Date());
        equipmentMapper.addEquipment(equipment);
        //如果工位不为空，则添加至工位表
        if (equipment.getWorkStationList() != null) {
            for (WorkStation workStation : equipment.getWorkStationList()) {
                workStation.setEquipmentInt(equipment.getEquipmentInt());
                equipmentMapper.addWorkStation(workStation);
            }
        }
    }

    /**
     * 根据资源号删除
     *
     * @param equipmentInt 设备号
     */
    public void removeEquipment(int equipmentInt) {
        List<WorkStation> workStationList = equipmentMapper.queryWorkStation(equipmentInt);
        //如果存在工位信息，删除
        if(workStationList.size()>0){
            for(WorkStation workStation: workStationList){
                equipmentMapper.removeWorkStation(workStation.getWorkStationId());
            }
        }
        equipmentMapper.removeEquipment(equipmentInt);
    }

    /**
     * 更新设备
     */
    public void updateEquipment(Equipment equipment) {
        List<WorkStation> workStationList = equipmentMapper.queryWorkStation(equipment.getEquipmentInt());
        //如果存在工位信息，删除
        if(equipment.getWorkStationList() != null){
            for(WorkStation workStation: workStationList){
                equipmentMapper.removeWorkStation(workStation.getWorkStationId());
            }
        }
        equipmentMapper.updateEquipment(equipment);
        //如果工位不为空，则添加至工位表
        if (equipment.getWorkStationList() != null ) {
            for (WorkStation workStation : equipment.getWorkStationList()) {
                workStation.setEquipmentInt(equipment.getEquipmentInt());
                equipmentMapper.addWorkStation(workStation);
            }
        }

    }

    /**
     * 查询记录
     */
    public int count(String equipmentId, String equipmentName ,String enable, String processName) {
        return equipmentMapper.count(equipmentId, equipmentName ,enable, processName);
    }

    /**
     * 批量删除终端
     */
    public void deleteEquipments(List<Integer> equipmentInt) {
        //从表中获取设备的对应工位信息
        for (Integer a: equipmentInt) {
            List<WorkStation> workStationList = equipmentMapper.queryWorkStation(a);
            //如果存在工位信息，删除
            if(workStationList.size()>0){
                for(WorkStation workStation: workStationList){
                    equipmentMapper.removeEquipment(workStation.getWorkStationId());
                }
            }
        }
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

    /**
     * 检测设备连接IP是否存在
     *
     * @param equipmentIp 设备连接Ip
     */
    public int checkEquipmentIp(String equipmentIp,String equipmentInt) {
        return equipmentMapper.checkEquipmentIp(equipmentIp,equipmentInt);
    }

    /**
     * 查询设备对应的工位
     * @param equipmentInt
     * @return
     */
    public Equipment queryWorkStation(int equipmentInt){
        Equipment equipment = new Equipment();
        List<WorkStation> workStationList = equipmentMapper.queryWorkStation(equipmentInt);
        if (workStationList!= null && workStationList.size()>0){
            equipment.setWorkStationList(workStationList);
        }
        return equipment;
    }


}
