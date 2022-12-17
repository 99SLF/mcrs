package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.pojo.DeviceVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 终端
 *
 * @author 林俊杰
 * @date 2022/11/30
 */
@Mapper
public interface DeviceMapper {

    /**
     * 查询全部终端信息
     *
     * @return
     */
    List<DeviceVo> queryAll(Map map);

    /**
     * 注册终端
     *
     * @return
     */
    void registrationDevice(Device device);

    /**
     * 依据Appid注销终端
     *
     * @return
     */
    public void logoutDevice(int deviceId);

    /**
     * 修改终端
     *
     * @return
     */
    void updateDevice(Device device);

    /**
     * 终端配置
     * @return
     */
//    List<Device> configDevice(Device device);

    /**
     * 计数
     *
     * @return
     */
    int count(@Param("equipmentId") String equipmentId, @Param("APPId") String APPId);

    /**
     * 返回数据给监控
     */
    List<Device> toMonitor(Map map);

}
