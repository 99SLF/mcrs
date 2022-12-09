package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.device.pojo.DeviceUpdate;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 终端更新
 *
 * @author 林俊杰
 * @date 2022/12/1
 */
@Mapper
public interface DeviceUpdateMapper {

    /**
     * 查询全部更新信息
     * @return
     */
    List<DeviceUpdate> queryAll(Map map);


    /**
     * 计算条数
     */
    int count(@Param("equipmentId") String equipmentId, @Param("version") String version);


    /**
     * 回退
     * @return
     */
//    void rollback();

    /**
     * 删除
     * @return
     */
//    public void remove();
}
