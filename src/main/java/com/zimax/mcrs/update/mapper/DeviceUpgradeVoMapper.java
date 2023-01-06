package com.zimax.mcrs.update.mapper;

import com.zimax.mcrs.update.pojo.DeviceUpgradeVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DeviceUpgradeVoMapper {
    /**
     * 通过APPID查询终端升级信息
     * @param APPId
     * @return
     */
    DeviceUpgradeVo getDevice(String APPId);
}
