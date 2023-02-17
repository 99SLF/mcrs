package com.zimax.mcrs.monitor.mapper;

import com.zimax.mcrs.monitor.pojo.monDeviceStatus.MonitorDeviceHistory;
import com.zimax.mcrs.monitor.pojo.monDeviceStatus.MonitorDeviceStatus;
import com.zimax.mcrs.monitor.pojo.vo.GroupByDate;
import com.zimax.mcrs.monitor.pojo.vo.GroupByProduction;
import com.zimax.mcrs.monitor.pojo.vo.ProcessOnfactory;
import com.zimax.mcrs.monitor.pojo.vo.WarnTotalInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/12 0:32
 */
@Mapper
public interface AccessMonitorMapper {

//    /**
//     * 新增软件运行状态信息
//     */
//    void addSoftwareRunStatus(SoftwareRunStatus softwareRunStatus);
//
//    /**
//     * 新增设备接入状态信息
//     */
//    void addEquipmentStatus(EquipmentStatus equipmentStatus);
//
//    /**
//     * 新增终端异常预警信息
//     */
//    void addDeviceAbn(DeviceAbn deviceAbn);


    /**
     * 对外获取终端设备，硬件软件的运行状态（表+++mon_device_history）
     */
    void addMonitorDeviceStatus(MonitorDeviceHistory monitorDeviceHistory);

    int updateMonitorDeviceStatus(MonitorDeviceStatus monitorDeviceStatus);

    /**
     * 对内每次注册一个终端信息的话，就新增表里一条终端名为注册名的监控信息（表+++mon_device_real）
     */
    void addMonitorDeviceReal(MonitorDeviceStatus monitorDeviceStatus);

    /**
     * 对内每次注销一个终端信息的话，就修改表里一条终端名为注册名的监控信息（表+++mon_device_real）
     */
    void updateMonitorDeviceRealExist(MonitorDeviceStatus deviceName);


    /**
     * 检查终端状态表，是否存在该终端数据
     */
    List<MonitorDeviceStatus> checkDevice(Map map);

    int getEqiOnline();
    int getAccessOnline();

    GroupByProduction[] getWarnByproduction();
    List<GroupByDate> groupQueryBydate();

    WarnTotalInfo getWarnInfo();
    GroupByProduction[] queryProcessAndeqi();
    int[] queryFactoryId();
    String[] queryProcessName();
    ProcessOnfactory[] queryFactoryAndProcess();
}
