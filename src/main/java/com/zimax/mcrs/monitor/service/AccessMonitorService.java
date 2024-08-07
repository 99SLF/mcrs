package com.zimax.mcrs.monitor.service;

import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.monitor.mapper.AccessMonitorMapper;
import com.zimax.mcrs.monitor.pojo.monDeviceStatus.MonitorDeviceAlarm;
import com.zimax.mcrs.monitor.pojo.monDeviceStatus.MonitorDeviceHistory;
import com.zimax.mcrs.monitor.pojo.monDeviceStatus.MonitorDeviceStatus;
import com.zimax.mcrs.monitor.pojo.vo.*;
import com.zimax.mcrs.warn.pojo.AlarmEventVo;
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

//    /**
//     * 新增软件运行状态信息
//     */
//    public void addSoftwareRunStatus(SoftwareRunStatus softwareRunStatus){
//
//        softwareRunStatus.setCreateTime(new Date());
//        accessMonitorMapper.addSoftwareRunStatus(softwareRunStatus);
//    }
//
//    /**
//     * 新增设备接入状态信息
//     */
//    public void addEquipmentStatus( EquipmentStatus equipmentStatus){
//
//        equipmentStatus.setCreateTime(new Date());
//        accessMonitorMapper.addEquipmentStatus(equipmentStatus);
//    }
//
//    /**
//     * 新增终端异常预警信息
//     */
//    public void addDeviceAbn(DeviceAbn deviceAbn){
//
//        deviceAbn.setCreateTime(new Date());
//        accessMonitorMapper.addDeviceAbn(deviceAbn);
//    }


    /**
     * 对外获取终端设备，硬件软件的运行状态（表+++mon_device_history）
     */
    public void addMonitorDeviceStatus(MonitorDeviceHistory monitorDeviceHistory){
        accessMonitorMapper.addMonitorDeviceStatus(monitorDeviceHistory);
    }

    /**
     * 对内每次被调用新增接口存终端状态信息时，就往终端状态表里修改一条终端名为，存在的当前终端名称为接口添加名称的监控信息（表+++mon_device_real）
     * @return
     */
    public int updateMonitorDeviceStatus(MonitorDeviceStatus monitorDeviceStatus){
        return  accessMonitorMapper.updateMonitorDeviceStatus(monitorDeviceStatus);

    }

    /**
     * appid删除终端状态
     */
    public void deleteDeviceStatus(String appId) {
        accessMonitorMapper.deleteDeviceStatus(appId);
    }

    /**
     * 对内每次注册一个终端信息的话，就往表里新增一条终端名为注册名的监控信息（表+++mon_device_real）
     */
    public void addMonitorDeviceReal(MonitorDeviceStatus monitorDeviceStatus){
        accessMonitorMapper.addMonitorDeviceReal(monitorDeviceStatus);
    }

    /**
     * 对内每次注销一个终端信息的话，就修改表里一条终端名为注册名的监控信息（表+++mon_device_real）
     */
    public void updateMonitorDeviceRealExist(MonitorDeviceStatus monitorDeviceStatus){
        accessMonitorMapper.updateMonitorDeviceRealExist(monitorDeviceStatus);
    }


    /**
     * 通过终端名称查询是否存在该终端数据
     */
    public List<MonitorDeviceStatus> checkDevice(String deviceName) {
        Map<String, Object> map = new HashMap<>();
        map.put("deviceName", deviceName);
        return accessMonitorMapper.checkDevice(map);
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
        //int accessOnline = accessMonitorMapper.getAccessOnline();
        EqiAndAccessInfo eqiAndAccessInfo = new EqiAndAccessInfo();
        //eqiAndAccessInfo.setAccessOnline(accessOnline);
        eqiAndAccessInfo.setEqiOnline(eqiOnline);
        return eqiAndAccessInfo;
    }
    public Map queryProcessAndFactory(){
        Map<String,Object> map = new HashMap<>();
        List<List<Integer>> dataTotalList = new ArrayList<List<Integer>>();
        List<String> factoryName= new ArrayList();
        List<Integer> factoryId = new ArrayList();
        //查询添加设备包含的工序名字
        String[] processNames = accessMonitorMapper.queryProcessName();
        ProcessOnfactory processOnfactoryList[] = accessMonitorMapper.queryFactoryAndProcess();
        for(int i=0;i<processOnfactoryList.length;i++){
            if(!factoryId.contains(processOnfactoryList[i].getFactoryId())){
                factoryId.add(processOnfactoryList[i].getFactoryId());
            }
            if(!factoryName.contains(processOnfactoryList[i].getFactoryName())){
                factoryName.add(processOnfactoryList[i].getFactoryName());
            }
        }

        List intData = null;
        for(int i=0;i<processNames.length;i++){//以工序区分不同工厂的数量
            intData = new ArrayList<Integer>();
            for(int k=0;k<factoryId.size();k++){
                for(int j=0;j<processOnfactoryList.length;j++){
                    if(processNames[i].equals(processOnfactoryList[j].getProcessName())&&factoryId.get(k)==processOnfactoryList[j].getFactoryId()){
                        intData.add(processOnfactoryList[j].getTotal());
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


    /**
     * 将终端告警信息存储到终端告警记录表中（表+++mon_device_alarm）
     */

        public void addDeviceAlarm(MonitorDeviceAlarm monitorDeviceAlarm){

        accessMonitorMapper.addDeviceAlarm(monitorDeviceAlarm);
    }


    public List<AlarmEventVo> findAlarmEvent(String warningContent) {
        return accessMonitorMapper.findAlarmEvent(warningContent);

    }
}
