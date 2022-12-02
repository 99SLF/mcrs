package com.zimax.mcrs.device.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.mcrs.device.pojo.Device;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * 设备
 * @author 林俊杰
 * @date 2022/11/28
 */
public interface DeviceMapper {

   @Autowired

    /**
     * 初始化查询
     * @return
     */
    public List<Device> queryDevice();

    /**
     * 依据设备id查询设备
     * @return
     */
    public Device getDevice(int deviceId);

    /**
     * 添加设备
     * @return
     */
    public void addDevice(Device device);

    /**
     * 删除设备
     * @return
     */
    public void removeDevice(int deviceId);

    /**
     * 更新设备
     * @return
     */
    public void updateDevice(Device device);

}
