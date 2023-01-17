package com.zimax.mcrs.monitor.mapper;

import com.zimax.mcrs.monitor.pojo.DeviceAbn;
import com.zimax.mcrs.monitor.pojo.EquipmentStatus;
import com.zimax.mcrs.monitor.pojo.SoftwareRunStatus;
import com.zimax.mcrs.monitor.pojo.vo.GroupByDate;
import com.zimax.mcrs.monitor.pojo.vo.GroupByProduction;
import com.zimax.mcrs.monitor.pojo.vo.WarnTotalInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/12 0:32
 */
@Mapper
public interface AccessMonitorMapper {

    /**
     * 新增软件运行状态信息
     */
    void addSoftwareRunStatus(SoftwareRunStatus softwareRunStatus);

    /**
     * 新增设备接入状态信息
     */
    void addEquipmentStatus(EquipmentStatus equipmentStatus);

    /**
     * 新增终端异常预警信息
     */
    void addDeviceAbn(DeviceAbn deviceAbn);
    int getEqiOnline();
    int getAccessOnline();

    GroupByProduction getWarnByproduction();
    List<GroupByDate> groupQueryBydate();

    WarnTotalInfo getWarnInfo();
    GroupByProduction queryProcessAndeqi();
}
