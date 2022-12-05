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
     * 初始化查询
     * @return
     */
    public List<DeviceUpdate> queryAll(){
        return null;
    }

    /**
     * 条件查询
     * @return
     */
    public List<DeviceUpdate> query(){
        return null;
    }

    /**
     * 下载
     * @return
     */
    public void download(){

    }


    /**
     * 删除
     * @return
     */
    public void remove(){

    }


    


}
