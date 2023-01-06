package com.zimax.mcrs.update.mapper;

import com.zimax.mcrs.update.pojo.DeviceEquipmentVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DeviceEquipmentVoMapper {

    /**
     * 通过IP\端口查询终端信息
     * @param Ip
     * @param Port
     * @return
     */
    DeviceEquipmentVo getDeviceEquipmentVo(String Ip, String Port);
}
