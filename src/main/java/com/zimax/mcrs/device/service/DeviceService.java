package com.zimax.mcrs.device.service;

import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.mapper.DeviceMapper;
import com.zimax.mcrs.device.pojo.Device;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 设备终端服务
 * @author 林俊杰
 * @date 2022/11/30
 */
@Service
public class DeviceService {

    @Autowired
    private DeviceMapper deviceMapper;

    /**
     * 查询所有终端信息
     * @return
     */
    public List<Device> queryDevices(int page, int limit, String equipmentId, String APPId, String order, String field) {
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
        map.put("APPId",APPId);
        return deviceMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(String equipmentId, String APPId){
        return deviceMapper.count(equipmentId,APPId);
    }


    /**
     * 注册终端
     * @param device 终端
     */
    public void registrationDevice(Device device) {
        deviceMapper.registrationDevice(device);

    }

    /**
     * 注销终端
     * @param APPId 根据APPID注销
     */
    public void logoutDevice(String APPId) {
        deviceMapper.logoutDevice(APPId);
    }

    /**
     * 初始化查询
     */
    public void updateDevice(Device device) {
        deviceMapper.updateDevice(device);
    }

    /**
     * 根据APPId查询
     * @param APPId 依据APPId查询
     */
    public Device queryAPPId(int APPId) {
        return null;
    }

    /**
     * 根据设备资源号查询
     * @param equipmentId 依据设备资源号查询
     */
    public Device queryEquipmentId(int equipmentId) {
        return null;
    }

    /**
     * 根据终端软件类型查询
     * @param deviceSoftwareType 依据终端软件类型查询
     */
    public Device queryDeviceSoftwareType(String deviceSoftwareType) {
        return null;
    }


}
