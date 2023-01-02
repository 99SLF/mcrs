package com.zimax.mcrs.device.mapper;

import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.pojo.DeviceUpgrade;
import com.zimax.mcrs.device.pojo.DeviceUpgradeVo;
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
    int count(@Param("equipmentId") String equipmentId, @Param("upgradeVersion") String upgradeVersion);


    void updateDeviceUpgrade(DeviceUpgrade deviceUpgrade);

}
