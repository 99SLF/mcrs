package com.zimax.mcrs.device.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zimax.mcrs.device.pojo.Device;
import org.apache.ibatis.annotations.Mapper;

/**
 * 设备
 * @author 林俊杰
 * @date 2022/11/28
 */
@Mapper
public interface DeviceMapper extends BaseMapper<Device> {
}
