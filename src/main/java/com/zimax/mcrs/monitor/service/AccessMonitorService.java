package com.zimax.mcrs.monitor.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.monitor.mapper.AccessMonitorMapper;
import com.zimax.mcrs.monitor.pojo.DeviceAbn;
import com.zimax.mcrs.monitor.pojo.EquipmentStatus;
import com.zimax.mcrs.monitor.pojo.SoftwareRunStatus;
import com.zimax.mcrs.monitor.pojo.vo.GroupByDate;
import com.zimax.mcrs.monitor.pojo.vo.GroupByProduction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * @author 李伟杰
 * @date 2022/12/12 0:27
 */
@Service
public class AccessMonitorService {
    @Autowired
    private AccessMonitorMapper accessMonitorMapper;

    /**
     * 新增软件运行状态信息
     */
    public void addSoftwareRunStatus(SoftwareRunStatus softwareRunStatus){

        softwareRunStatus.setCreateTime(new Date());
        accessMonitorMapper.addSoftwareRunStatus(softwareRunStatus);
    }

    /**
     * 新增设备接入状态信息
     */
    public void addEquipmentStatus( EquipmentStatus equipmentStatus){

        equipmentStatus.setCreateTime(new Date());
        accessMonitorMapper.addEquipmentStatus(equipmentStatus);
    }

    /**
     * 新增终端异常预警信息
     */
    public void addDeviceAbn(DeviceAbn deviceAbn){

        deviceAbn.setCreateTime(new Date());
        accessMonitorMapper.addDeviceAbn(deviceAbn);
    }


    public List<GroupByProduction> groupQueryByproduction() {
        return accessMonitorMapper.groupQueryByproduction();
    }
    public List<GroupByDate> groupQueryBydate() {
        List<GroupByDate> groupByDates = accessMonitorMapper.groupQueryBydate();
        List<GroupByDate> groupByDateList = new ArrayList<>();
        if(groupByDates.size()>0){
            for(int i=groupByDates.size()-1;i>=0;i--){
                groupByDateList.add(groupByDates.get(i));
            }
        }
        return groupByDateList;

    }

}
