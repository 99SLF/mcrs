package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.device.pojo.*;
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
     * 终端主页计数
     *
     * @return
     */
    int counts(@Param("equipmentId") String equipmentId,
               @Param("equipmentIp") String equipmentIp,
              @Param("deviceSoftwareType") String deviceSoftwareType,
              @Param("enable")String enable,
              @Param("deviceName")String deviceName,
              @Param("processName")String processName,
              @Param("factoryName")String factoryName,
              @Param("version")String version,
              @Param("needUpdate")String needUpdate,
              @Param("registerStatus")String registerStatus,
              @Param("programInstallationPath")String programInstallationPath,
              @Param("createTime")String createTime);

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
     * 修改终端状态
     *
     * @return
     */
    void updateDeviceStatus(Device device);
    /**
     * 修改终端路径
     *
     * @return
     */
    void updateDevicePath (Device device);

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
    DeviceNum countReg();

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


    /**
     * 验证当前终端软件类型是否存在更新包
     *
     * @return
     */
    int checkDeviceSoftwareType(@Param("deviceSoftwareType") String deviceSoftwareType);

    /**
     * 获取更新包对应的主键
     *
     * @return
     */
    int getUpgradeId (@Param("version") String version,@Param("deviceSoftwareType") String deviceSoftwareType);

    /**
     * 查询当前设备是否已被注册
     *
     * @return
     */
    int checkEquipment(@Param("equipmentInt")int equipmentInt);

    /**
     * 依据终端主键查询终端信息
     *
     * @return
     */
    Device selectDevice(@Param("deviceId") int deviceId);
    String queryDevice(@Param("appId") String apId);
    /**
     * 通过终端主键获取终端信息
     */
    Device getDeviceName(int deviceId);
}
