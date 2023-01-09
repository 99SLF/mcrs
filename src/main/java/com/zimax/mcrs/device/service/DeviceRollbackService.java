package com.zimax.mcrs.device.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.mapper.DeviceRollbackMapper;
import com.zimax.mcrs.device.pojo.DeviceRollback;
import com.zimax.mcrs.device.pojo.DeviceRollbackVo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 终端更新记录
 * @author 林俊杰
 * @date 2022/11/30
 */
@Service
public class DeviceRollbackService {

    @Autowired
    private DeviceRollbackMapper deviceRollbackMapper;
    /**
     * 查询所有终端更新信息
     */
    public List<DeviceRollbackVo> queryDeviceRollback(String  page, String limit, String equipmentId, String upgradeVersion, String versionRollbackPeople, String versionRollbackTime, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","version_rollback_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId",equipmentId);
        map.put("upgradeVersion",upgradeVersion);
        map.put("versionRollbackPeople",versionRollbackPeople);
        map.put("versionRollbackTime",versionRollbackTime);
        return deviceRollbackMapper.queryAll(map);
    }

    /**
     * 计数
     */
    public int count(String equipmentId, String upgradeVersion){
        return deviceRollbackMapper.count(equipmentId,upgradeVersion);
    }

    /**
     * 新增回退记录
     * @param
     * @return
     */
    public void addDeviceRollback(DeviceRollback deviceRollback){
        deviceRollbackMapper.addDeviceRollback(deviceRollback);

    }

    /**
     * 检测存在信息
     *
     * @param deviceUpgradeId
     */
    public int check(String deviceUpgradeId) {
        return deviceRollbackMapper.check(deviceUpgradeId);
    }


    /**
     * 通过升级表id获取回退记录表的已回退数据的List
     * @param
     * @return
     */
    public List<DeviceRollback> queryRollbackMsg(String deviceUpgradeId) {
        Map<String, Object> map = new HashMap<>();
        map.put("deviceUpgradeId", deviceUpgradeId);
        return deviceRollbackMapper.queryRollbackMsg(map) ;
    }
}
