package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.device.pojo.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 终端版本更新信息
 *
 * @author 林俊杰
 * @date 2022/12/13
 */
@Mapper
public interface DeviceRollbackMapper {

    /**
     * 查询全部的更新信息（回退表）
     */
    List<DeviceRollbackVo> queryAll(Map map);

    /**
     * 计数（回退表）
     *
     * @return
     */
    int count(@Param("deviceName") String deviceName,@Param("deviceSoftwareType") String deviceSoftwareType,
              @Param("equipmentId") String equipmentId,@Param("equipmentName") String equipmentName,
              @Param("equipTypeName") String equipTypeName,@Param("uploadNumber") String uploadNumber,
              @Param("version") String version,@Param("accPointResName") String accPointResName, @Param("createName") String createName ,
              @Param("versionRollbackTime") String versionRollbackTime);


    /**
     * 修改回滚表
     * @param deviceRollback
     */
    void updateDeviceRollback(DeviceRollback deviceRollback);


    /**
     * 修改回滚表全部
     * @param deviceRollback
     */
    void updateDeviceRollbackAll(DeviceRollback deviceRollback);

    void addDeviceRollback(DeviceRollback deviceRollback);


    /**
     * 检查当前APPId是否存在
     */
    int check(@Param("deviceUpgradeId") String deviceUpgradeId);


    /**
     * 通过升级表id获取记录数
     */
    List<DeviceRollback> queryRollbackMsg(Map map);

    List<DeviceUploadRollbackVo> queryRollRecordId(Map map);
}

