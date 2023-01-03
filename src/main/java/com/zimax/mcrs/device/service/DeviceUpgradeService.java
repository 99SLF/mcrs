package com.zimax.mcrs.device.service;

import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.mapper.DeviceUpgradeMapper;
import com.zimax.mcrs.device.pojo.DeviceUpgrade;
import com.zimax.mcrs.device.pojo.DeviceUpgradeVo;
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
public class DeviceUpgradeService {

    @Autowired
    private DeviceUpgradeMapper deviceUpgradeMapper;
    /**
     * 查询所有终端更新信息
     */
    public List<DeviceUpgradeVo> queryDeviceUpgrades(String  page, String limit, String equipmentId, String upgradeVersion,String versionUpdater, String versionUpdateTime, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","version_update_time");
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
        map.put("versionUpdater",versionUpdater);
        map.put("versionUpdateTime",versionUpdateTime);
        return deviceUpgradeMapper.queryAll(map);
    }

    /**
     * 计数
     */
    public int count(String equipmentId, String upgradeVersion){
        return deviceUpgradeMapper.count(equipmentId,upgradeVersion);
    }

    public void updateDeviceUpgrade(DeviceUpgrade deviceUpgrade) {
        deviceUpgradeMapper.updateDeviceUpgrade(deviceUpgrade);
    }

}
