package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.pojo.DeviceEquipmentVo;
import com.zimax.mcrs.device.pojo.DeviceVo;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.update.pojo.UpdateUpload;
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
     * 依据deviceId注销终端
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

    /**
     * 批量删除
     * @param deviceId
     */
    void deleteDevices(List<Integer> deviceId);

    /**
     * 检查当前APPId是否存在
     */
    int checkAPPId(@Param("APPId") String APPId);


    /**
     * 通过终端主键获取设备信息
     * @param
     * @return
     */
    DeviceEquipmentVo getEquipment(int deviceId);

}
