package com.zimax.mcrs.device.service;

import com.zimax.mcrs.device.mapper.DeviceUpdateMapper;
import com.zimax.mcrs.device.pojo.DeviceUpdate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 终端更新
 * @author 林俊杰
 * @date 2022/12/1
 */
@Service
public class DeviceUpdateService {

    @Autowired
    private DeviceUpdateMapper deviceUpdateMapper;

    /**
     * 查询所有终端的版本信息
     * @return
     */
    public List<DeviceUpdate> queryDeviceVersion(){
        return null;
    }

    /**
     * 依据终端更新编码查询
     * @return
     */
    public List<DeviceUpdate> queryDeviceUpdateId(){
        return null;
    }

    /**
     * 升级终端
     * @return
     */
    public void upgradeDeviceUpdate(){

    }

    /**
     * 导出终端升级信息
     * @return
     */
    public void exportDeviceUpdateText(){

    }
    /**
     * 上传终端的版本
     * @return
     */
    public void uploadDeviceVersion(){

    }

    /**
     * 回退终端的版本
     * @return
     */
    public void fallbackDeviceVersion(){

    }


    


}
