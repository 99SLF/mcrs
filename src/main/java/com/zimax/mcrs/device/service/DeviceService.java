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
     * 添加设备信息
     * @param device 角色
     */
    public void addDevice(Device device){
        deviceMapper.insert(device);
    }

    /**
     * 根绝设备编号删除
     * @param deviceId 设备编号
     */
    public void deleteById(int deviceId){
        deviceMapper.deleteById(deviceId);
    }

    /**
     * 更新设备
     */
    public void updateDevice(Device device){
        deviceMapper.updateById(device);

    }

    /**
     * 查询设备
     */
    public List<Device> queryAll(){
        return deviceMapper.selectList(null);
    }

    /**
     * 根据设备编号查询
     */
    public Device query(int deviceId){
        return deviceMapper.selectById(deviceId);
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
