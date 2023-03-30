package com.zimax.mcrs.monitor.mapper;

import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.monitor.pojo.vo.EquipmentStatusVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/1/3 15:42
 */
@Mapper
public interface EquipmentRuntimeMapper {


    /**
     * 查询PLC设备接入信息
     * @param
     * @return
     */
    List<EquipmentStatusVo> queryEquipmentAccessP(Map map);

    /**
     * 查询PLC设备接入记录数
     * @param
     * @return
     */
    int countEQP(@Param("equipmentId") String equipmentId, @Param("plcStatus") String plcStatus
    );

    /**
     * 查询RFID设备接入信息
     * @param
     * @return
     */
    List<EquipmentStatusVo> queryEquipmentAccessR(Map map);

    /**
     * 查询RFID设备接入记录数
     * @param
     * @return
     */
    int countEQR(@Param("equipmentId") String equipmentId, @Param("rfidStatus") String rfidStatus,
                 @Param("antennaStatus") String antennaStatus
    );

    List<Equipment> findEquipmentId(String appId);
}
