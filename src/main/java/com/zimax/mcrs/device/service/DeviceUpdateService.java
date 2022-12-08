package com.zimax.mcrs.device.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.mapper.DeviceUpdateMapper;
import com.zimax.mcrs.device.pojo.DeviceUpdate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 终端更新
 *
 * @author 林俊杰
 * @date 2022/12/1
 */
@Service
public class DeviceUpdateService {

    @Autowired
    private DeviceUpdateMapper deviceUpdateMapper;

    /**
     * 查询全部更行信息
     *
     * @return
     */
    public List<DeviceUpdate> queryDeviceUpdate(int page, int limit, String equipmentId, String version, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","version_change_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        map.put("begin",limit*(page-1));
        map.put("limit",limit);
        map.put("equipmentId",equipmentId);
        map.put("version",version);
        return deviceUpdateMapper.queryAll(map);
    }

    /**
     * 计算条数
     */
    public int count(String equipmentId, String version){
        return deviceUpdateMapper.count(equipmentId,version);
    }

    /**
     * 条件查询
     *
     * @return
     */
    public List<DeviceUpdate> query() {
        return null;
    }

    /**
     * 下载
     *
     * @return
     */
    public void download() {

    }


    /**
     * 删除
     *
     * @return
     */
    public void remove() {

    }


}
