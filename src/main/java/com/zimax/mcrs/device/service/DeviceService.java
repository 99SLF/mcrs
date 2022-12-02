package com.zimax.mcrs.device.service;

import com.zimax.mcrs.device.mapper.DeviceMapper;
import com.zimax.mcrs.device.pojo.Device;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 设备服务
 * @author 林俊杰
 * @date 2022/11/28
 */
@Service
public class DeviceService {

    @Autowired
    private DeviceMapper deviceMapper;

    /**
     * 初始化查询
     */
    public List<Device> queryDevices(){
        System.out.println(deviceMapper.queryDevice());
        return null;
    }

    /**
     * 根据设备编号查询
     */
    public Device querydevice(int deviceId){
        System.out.println(deviceMapper.getDevice(deviceId));
        return null;
    }

    /**
     * 添加设备信息
     * @param device 角色
     */
    public void addDevice(Device device){

    }

    /**
     * 根绝设备编号删除
     * @param deviceId 设备编号
     */
    public void deleteById(int deviceId){
    }

    /**
     * 更新设备
     */
    public void updateDevice(Device device){

    }




    /**
     * 查询所有设备信息
     * @return
     */
    public List<Device> queryDevice(int page, int limit){
//        QueryWrapper<Device> queryWrapper = new QueryWrapper<>();
//        List<Device> deviceList = deviceMapper.selectList(queryWrapper);
//        System.out.println(deviceList.toString());
        return null;
    }

}
