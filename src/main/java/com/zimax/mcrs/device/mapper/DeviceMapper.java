package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.device.pojo.Device;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 终端
 * @author 林俊杰
 * @date 2022/11/30
 */
@Mapper
public interface DeviceMapper {

    /**
     * 初始化查询
     * @return
     */
//    List<Device> queryAll();
    /**
     *  注册终端
     * @return
     */
//    public void registrationDevice(Device device);

    /**
     * 依据Appid注销终端
     * @return
     */
//    public void logoutByID(int APPId);

    /**
     * 依据AppId查询
     * @return
     */
//    public List<Device> queryAPPId(int APPId);

    /**
     * 依据设备资源号查询
     * @return
     */
//    public List<Device> queryDeviceType(int equipmentId);

}
