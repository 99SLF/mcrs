package com.zimax.mcrs.monitor.service;

import com.sun.corba.se.impl.oa.toa.TOA;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.monitor.mapper.AccessMonitorMapper;
import com.zimax.mcrs.monitor.pojo.DeviceAbn;
import com.zimax.mcrs.monitor.pojo.EquipmentStatus;
import com.zimax.mcrs.monitor.pojo.SoftwareRunStatus;
import com.zimax.mcrs.monitor.pojo.vo.*;
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


    public GroupByProduction[] getWarnByproduction() {
        return accessMonitorMapper.getWarnByproduction();
    }
    public GroupByProduction[] queryProcessAndeqi() {
        return accessMonitorMapper.queryProcessAndeqi();
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

    public WarnTotalInfo getWarnInfo() {
        return accessMonitorMapper.getWarnInfo();
    }
    public EqiAndAccessInfo getEqiAndAccess() {
        int eqiOnline = accessMonitorMapper.getEqiOnline();
        int accessOnline = accessMonitorMapper.getAccessOnline();
        EqiAndAccessInfo eqiAndAccessInfo = new EqiAndAccessInfo();
        eqiAndAccessInfo.setAccessOnline(accessOnline);
        eqiAndAccessInfo.setEqiOnline(eqiOnline);
        return eqiAndAccessInfo;
    }
    public Map queryProcessAndFactory(){
        int[] factoryId = accessMonitorMapper.queryFactoryId();
        Map<String,Object> map = new HashMap<>();
        List<List<Integer>> dataTotalList = new ArrayList<List<Integer>>();
        String[] processNames = accessMonitorMapper.queryProcessName();
        ProcessOnfactory processOnfactoryList[] = accessMonitorMapper.queryFactoryAndProcess();
        List intData = null;
        List factoryName = new ArrayList<String>();
        for(int i=0;i<processNames.length;i++){
            intData = new ArrayList<Integer>();
            for(int k=0;k<factoryId.length;k++){
                for(int j=0;j<processOnfactoryList.length;j++){
                    if(processNames[i].equals(processOnfactoryList[j].getProcessName())&&factoryId[k]==processOnfactoryList[j].getFactoryId()){
                        intData.add(processOnfactoryList[j].getTotal());
                        if(i==0){
                            factoryName.add(processOnfactoryList[j].getFactoryName());
                        }
                        break;
                    }
                    if(j==processOnfactoryList.length-1){
                        intData.add(0);
                    }
                }
            }
            dataTotalList.add(intData);
        }
        List<String> processName = new ArrayList<String>();
        for(String x: processNames){
            processName.add(x);
        }
        map.put("factoryName",factoryName);
        map.put("processName",processName);
        map.put("dataTotalList",dataTotalList);
        return map;
    }

}
