package com.zimax.mcrs.update.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
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

import java.io.File;
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
        String fileName = path.substring(path.lastIndexOf("\\")+1);
        configurationFile.setFileName(fileName);
        configurationFile.setFileStatus("101");
        IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
        //将当期的用户信息存储到数据库表里
        configurationFile.setCreator(usetObject.getUserName());

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
        File file = new File(configurationFile.getFilePath());
        if(!file.exists()) {
        }else{
            if(file.delete()){
                configurationFileMapper.delConfigurationFile(configurationFile);
            }
        }


    }
    public void delConfigurationFileByAppId(String appId) {
        List<ConfigurationFile> configurationFile = configurationFileMapper.getConfigurationFile(appId,null);
        if(configurationFile.size()==0){
            return;
        }
        String path = configurationFile.get(0).getFilePath();
        String str = path.substring(0,path.lastIndexOf("/"));

        File file = new File(str);
       if(deleteFile(file)){
           configurationFileMapper.delConfigurationFileByAppId(appId);
       }
    }
    public  Boolean deleteFile(File file) {
        //判断文件不为null或文件目录存在
        if (file == null || !file.exists()) {
            //System.out.println("文件保存路径不存在，正在创建");
            return false;
        }
        //获取目录下子文件
        File[] files = file.listFiles();
        //遍历该目录下的文件对象
        for (File f : files) {
            //判断子目录是否存在子目录,如果是文件则删除
            if (f.isDirectory()) {
                //递归删除目录下的文件
                deleteFile(f);
            } else {
                //文件删除
                f.delete();
                //打印文件名
                System.out.println("文件名：" + f.getName());
            }
        }
        //文件夹删除
        file.delete();
        System.out.println("目录名：" + file.getName());
        return true;
    }
}
