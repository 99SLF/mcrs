package com.zimax.mcrs.update.mapper;

import com.zimax.mcrs.update.pojo.ConfigurationFile;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ConfigurationFileMapper {

    List<ConfigurationFile> getConfigurationFile(@Param("appId")String appId, @Param("fileName")String fileName);

    void updateConfigurationFile(ConfigurationFile configurationFile);
}
