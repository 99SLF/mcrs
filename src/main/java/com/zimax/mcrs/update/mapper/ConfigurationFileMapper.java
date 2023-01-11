package com.zimax.mcrs.update.mapper;

import com.zimax.mcrs.update.pojo.ConfigurationFile;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ConfigurationFileMapper {

    List<ConfigurationFile> getConfigurationFile(String appId, String fileName);

    void updateConfigurationFile(ConfigurationFile configurationFile);
}
