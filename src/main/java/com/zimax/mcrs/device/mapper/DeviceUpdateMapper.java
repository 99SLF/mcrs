package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.device.pojo.DeviceUpdate;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 终端更新
 * @author 林俊杰
 * @date 2022/12/1
 */
@Mapper
public interface DeviceUpdateMapper {

    /**
     * 初始化查询
     * @return
     */
    List<DeviceUpdate> queryAll();

    /**
     * 条件查询
     * @return
     */
    public void query();

    /**
     * 升级终端
     * @return
     */
//    public void upgradeDevice();

    /**
     * 导出终端更新信息
     * @return
     */
//    public void exportUpdateInfo();

    /**
     * 上传
     * @return
     */
//    public void upload();

    /**
     * 回退
     * @return
     */
//    public void rollback();
}
