package com.zimax.mcrs.device.service;

import com.zimax.mcrs.device.mapper.EquipmentMapper;
import com.zimax.mcrs.device.pojo.Equipment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
     * 初始化查询
     */
    public List<Equipment> queryEquipment(){
        return null;
    }

    /**
     * 根据设备资源号查询
     */
    public Equipment queryEquipment(int equipmentId){
        return null;
    }

    /**
     * 添加设备信息
     * @param equipment 角色
     */
    public void addEquipment(Equipment equipment){

    }

    /**
     * 根据资源号删除
     * @param equipmentId 设备资源号
     */
    public void deleteById(int equipmentId){
    }

    /**
     * 更新设备
     */
    public void updateEquipment(Equipment equipment){

    }




    /**
     * 查询所有设备信息
     * @return
     */
    public List<Equipment> queryEquipment(int page, int limit){
//        QueryWrapper<Device> queryWrapper = new QueryWrapper<>();
//        List<Device> deviceList = deviceMapper.selectList(queryWrapper);
//        System.out.println(deviceList.toString());
        return null;
    }

}
