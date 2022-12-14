package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.device.pojo.DeviceRollbackVo;
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
public interface DeviceRollbackMapper {

    /**
     * 查询全部的更新信息
     */
    List<DeviceRollbackVo> queryAll(Map map);

    /**
     * 计数
     *
     * @return
     */
    int count(@Param("equipmentId") String equipmentId, @Param("upgradeVersion") String upgradeVersion);



}
