package com.zimax.mcrs.update.mapper;

import com.zimax.mcrs.serialnumber.pojo.Serialnumber;
import com.zimax.mcrs.update.pojo.ConfigurationFile;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ConfigurationFileMapper {

    List<ConfigurationFile> getConfigurationFile(@Param("appId")String appId, @Param("fileName")String fileName);

    void updateConfigurationFile(ConfigurationFile configurationFile);

    void addConfigurationFile(ConfigurationFile configurationFile);

    List<ConfigurationFile> queryConfigurationFile(Map<String, Object> map);

    int count(String appId);

    void delConfigurationFile(ConfigurationFile configurationFile);
    void delConfigurationFileByAppId (String appId);
    void updateConfigurationFilebydow(ConfigurationFile configurationFile);
}
