package com.zimax.mcrs.device.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.mcrs.device.pojo.Device;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 设备
 * @author 林俊杰
 * @date 2022/11/28
 */
public interface DeviceMapper extends BaseMapper<Device> {

    /**
     * 初始化查询
     * @return
     */
    public List<Device> queryDevice();

    /**
     * 添加设备
     * @return
     */
    public void addDevice();


}
