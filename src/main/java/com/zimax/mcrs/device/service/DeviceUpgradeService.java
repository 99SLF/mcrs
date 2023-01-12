package com.zimax.mcrs.device.service;

import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.mapper.DeviceUpgradeMapper;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.pojo.DeviceUpgrade;
import com.zimax.mcrs.device.pojo.DeviceUpgradeVo;
import com.zimax.mcrs.device.pojo.DeviceUploadUpgradeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 终端更新记录
 *
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
    public List<DeviceUpgradeVo> queryDeviceUpgrades(String page, String limit, String deviceName,String deviceSoftwareType, String version, String versionUpdater, String versionUpdateTime, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "version_update_time");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("deviceName", deviceName);
        map.put("deviceSoftwareType", deviceSoftwareType);
        map.put("version", version);
        map.put("versionUpdater", versionUpdater);
        map.put("versionUpdateTime", versionUpdateTime);
        return deviceUpgradeMapper.queryAll(map);
    }

    /**
     * 计数
     */
    public int count(String deviceName,String deviceSoftwareType, String version, String versionUpdater, String versionUpdateTime) {
        return deviceUpgradeMapper.count(deviceName,deviceSoftwareType ,version ,versionUpdater,versionUpdateTime);
    }

    public void updateDeviceUpgrade(DeviceUpgrade deviceUpgrade) {
        deviceUpgradeMapper.updateDeviceUpgrade(deviceUpgrade);
    }

    public void addDeviceUpgrade(DeviceUpgrade deviceUpgrade) {
        deviceUpgradeMapper.addDeviceUpgrade(deviceUpgrade);
    }


    /**
     * 通过升级记录表的id获取该条升级记录
     * @param
     * @return
     */
    public DeviceUpgrade getDeviceUpgrade(int deviceUpgradeId) {
        return deviceUpgradeMapper.getDeviceUpgrade(deviceUpgradeId);
    }


    /**
     * 通过终端id获取升级记录为未更新的List(三个主键数据)
     * @param
     * @return
     */
    public List<DeviceUploadUpgradeVo> queryRecordId(String deviceId) {
        Map<String, Object> map = new HashMap<>();
        map.put("deviceId", deviceId);
        return deviceUpgradeMapper.queryRecordId(map) ;
    }

    /**
     * 通过终端id获取升级记录为未更新的对象(三个主键数据)
     * @param
     * @return
     */
    public DeviceUploadUpgradeVo queryRecordIdObject(int deviceId) {
        return deviceUpgradeMapper.queryRecordIdObject(deviceId) ;
    }

    /**
     * 通过终端id获取当前的版本号
     * @param
     * @return
     */
    public Device getVersion(int deviceId) {
        return deviceUpgradeMapper.getVersion(deviceId) ;
    }


    /**
     * 通过终端id获取升级记录数
     * @param
     * @return
     */
    public int queryRecordIdCount(int deviceId) {
        return deviceUpgradeMapper.queryRecordIdCount(deviceId) ;
    }
}
