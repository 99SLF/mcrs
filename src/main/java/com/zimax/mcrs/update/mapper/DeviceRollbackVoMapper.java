package com.zimax.mcrs.update.mapper;


import com.zimax.mcrs.update.pojo.DeviceRollbackVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DeviceRollbackVoMapper {
    /**
     * 通过APPID查询终端回退信息
     * @param appId
     * @return
     */
    DeviceRollbackVo getDevice(String appId);
}
