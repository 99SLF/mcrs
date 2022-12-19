package com.zimax.mcrs.device.service;

import com.zimax.components.coframe.rights.DefaultUserManager;
import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.mapper.DeviceMapper;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.pojo.DeviceVo;
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
    public List<DeviceVo> queryDevices(String  page, String limit, String equipmentId, String APPId, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","dev.create_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
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
        //调用方法加密，不使用，使用数据库MD5加密
//        device.setAPPId(encrypt(device.getAPPId()));
        deviceMapper.registrationDevice(device);
    }

    /**
     * 注销终端
     * @param deviceId 依据deviceId来注销终端
     */
    public void logoutDevice(int deviceId) {
        deviceMapper.logoutDevice(deviceId);
    }

    /**
     * 修改终端
     */
    public void updateDevice(Device device) {
        deviceMapper.updateDevice(device);
    }

    /**
     * 提供数据给监控
     */
    public List<Device> toMonitor(){
        Map<String,Object> map= new HashMap<>();
        return deviceMapper.toMonitor(map);
    }

    /**
     * 加密
     * @param
     * @return
     * @throws Exception
     */
    private static String encrypt(String APPId) throws Exception {
        return DefaultUserManager.INSTANCE.encodeString(APPId);
    }

    /**
     * 批量删除终端
     */
    public void deleteDevices(List<Integer> deviceId) {
        deviceMapper.deleteDevices(deviceId);
    }





}
