package com.zimax.mcrs.update.mapper;


import com.zimax.mcrs.update.pojo.DeviceEquipmentVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface DeviceEquipmentVoMapper {

    /**
     * 通过IP\端口查询终端信息
     * @param equipmentIp
     * @param equipmentContinuePort
     * @return
     */
    DeviceEquipmentVo getDeviceEquipmentVo(@Param("equipmentIp") String equipmentIp,@Param("equipmentContinuePort") String equipmentContinuePort);
}
