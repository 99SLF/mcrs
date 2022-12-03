package com.zimax.mcrs.device.service;

import com.zimax.mcrs.device.mapper.DeviceMapper;
import com.zimax.mcrs.device.pojo.Device;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
     * 注册终端
     * @param device 终端
     */
    public void registrationDevice(Device device) {

    }

    /**
     * 注销终端
     * @param APPId 根据APPID注销
     */
    public void logoutById(int APPId) {

    }

    /**
     * 初始化查询
     */
    public List<Device> queryAll() {
        return null;
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
     * @param deviceType 依据终端软件类型查询
     */
    public Device queryDeviceType(String deviceType) {
        return null;
    }


}
