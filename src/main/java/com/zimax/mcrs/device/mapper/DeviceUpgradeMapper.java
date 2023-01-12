package com.zimax.mcrs.device.mapper;

import com.zimax.components.coframe.rights.pojo.User;
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
public interface DeviceUpgradeMapper {

    /**
     * 查询全部的更新信息
     */
    List<DeviceUpgradeVo> queryAll(Map map);

    /**
     * 计数
     *
     * @return
     */
    int count(@Param("deviceName") String deviceName,@Param("deviceSoftwareType") String deviceSoftwareType, @Param("version") String version, @Param("versionUpdater") String versionUpdater ,@Param("versionUpdateTime") String versionUpdateTime);


    void updateDeviceUpgrade(DeviceUpgrade deviceUpgrade);

    /**
     * 修改升级状态
     * @param deviceUpgrade
     */
    void updateDeviceUpgradeStatus(DeviceUpgrade deviceUpgrade);

//  void addDeviceUpgrade(List<Integer> ids, String uploadIds);

    void addDeviceUpgrade(DeviceUpgrade deviceUpgrade);

    /**
     * 获取升级记录
     */
    DeviceUpgrade getDeviceUpgrade(int deviceUpgradeId);

    /**
     * 更新升级记录表
     * @param
     * @return
     */
    void updateDeviceUploadId(DeviceUpgrade deviceUpgrade);

    /**
     * 通过终端id获取记录数
     */
    List<DeviceUploadUpgradeVo> queryRecordId(Map map);


    DeviceUploadUpgradeVo queryRecordIdObject(int deviceId);

    Device getVersion(int deviceId);

    int queryRecordIdCount(int deviceId);
}
