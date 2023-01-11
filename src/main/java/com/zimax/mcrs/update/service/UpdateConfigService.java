package com.zimax.mcrs.update.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.mapper.DeviceMapper;
import com.zimax.mcrs.device.mapper.DeviceRollbackMapper;
import com.zimax.mcrs.device.mapper.DeviceUpgradeMapper;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.pojo.DeviceRollback;
import com.zimax.mcrs.device.pojo.DeviceUpgrade;
import com.zimax.mcrs.serialnumber.pojo.Serialnumber;
import com.zimax.mcrs.update.mapper.*;
import com.zimax.mcrs.update.pojo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/14 8:38
 */
@Service
public class UpdateConfigService {

    @Autowired
    private ConfigurationFileMapper configurationFileMapper;

    /**
     * 获取配置文件表
     * @param appId
     * @param fileName
     * @return
     */
    public List<ConfigurationFile> getConfigurationFile(String appId, String fileName) {
        return configurationFileMapper.getConfigurationFile(appId,fileName);
    }


    /**
     * 修改配置文件
     * @param configurationFile
     */
    public void updateConfigurationFile(ConfigurationFile configurationFile) {
        configurationFileMapper.updateConfigurationFile(configurationFile);
    }


    /**
     * 修改配置文件
     * @param configurationFile
     */
    public void addConfigurationFile(ConfigurationFile configurationFile) {
        String path = configurationFile.getConfigPath();
         path = path.trim();
        String fileName = path.substring(path.lastIndexOf("/")+1);
        configurationFile.setFileName(fileName);
        configurationFile.setFileStatus("101");
        configurationFileMapper.addConfigurationFile(configurationFile);

    }

    /**
     * 查询编码规则
     * @param page
     * @param limit
     * @param order
     * @param field
     * @return
     */
    public List<ConfigurationFile> queryConfigurationFile(String page, String limit, String appId, String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "file_id");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("appId", appId);
        return configurationFileMapper.queryConfigurationFile(map);
    }

    public int count(String appId){
        return configurationFileMapper.count(appId);
    }


    public void delConfigurationFile(ConfigurationFile configurationFile) {
        configurationFileMapper.delConfigurationFile(configurationFile);
    }
}
