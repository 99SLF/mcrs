package com.zimax.mcrs.device.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.mapper.EquipmentMapper;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.device.pojo.EquipmentVo;
import com.zimax.mcrs.device.pojo.WorkStation;
import com.zimax.mcrs.log.pojo.OperationLog;
import com.zimax.mcrs.log.service.OperationLogService;
import com.zimax.mcrs.warn.pojo.MonitorEquipment;
import com.zimax.mcrs.warn.pojo.MonitorEquipmentVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 设备服务
 *
 * @author 林俊杰
 * @date 2022/11/28
 */
@Service
public class EquipmentService {

    @Autowired
    private EquipmentMapper equipmentMapper;

    //操作日志服务层
    @Autowired
    private OperationLogService operationLogService;

    /**
     * 查询所有
     */
    public List<EquipmentVo> queryEquipments(String limit, String page,String equipmentId,String equipmentName, String enable, String equipmentInstallLocation, String equipTypeName, String protocolCommunication, String accPointResName, String processName, String createName, String createTime, String order, String field) {
        if (equipmentId!=null||equipmentName!=null||enable!=null||equipmentInstallLocation!=null||equipTypeName!=null||protocolCommunication!=null||accPointResName!=null||processName!=null||createName!=null||createTime!=null){
            Equipment equipment = new Equipment();
            addOperationLog(equipment,1);
        }
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "eqi.create_time");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId", equipmentId);
        map.put("equipmentName", equipmentName);
        map.put("enable", enable);
        map.put("equipmentInstallLocation", equipmentInstallLocation);
        map.put("equipTypeName", equipTypeName);
        map.put("protocolCommunication", protocolCommunication);
        map.put("accPointResName", accPointResName);
        map.put("processName", processName);
        map.put("createName", createName);
        map.put("createTime", createTime);
        return equipmentMapper.queryAll(map);
    }

    /**
     * 添加设备信息
     *
     * @param equipment 角色
     */
    public void addEquipment(Equipment equipment) {
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        equipment.setCreator(userObject.getUserId());
        equipment.setCreateTime(new Date());
        equipmentMapper.addEquipment(equipment);
        //如果工位不为空，则添加至工位表
        if (equipment.getWorkStationList() != null) {
            for (WorkStation workStation : equipment.getWorkStationList()) {
                workStation.setEquipmentInt(equipment.getEquipmentInt());
                equipmentMapper.addWorkStation(workStation);
            }
        }
        addOperationLog(equipment, 2);
    }

    /**
     * 根据资源号删除
     *
     * @param equipmentInt 设备号
     */
    public void removeEquipment(int equipmentInt) {
        List<WorkStation> workStationList = equipmentMapper.queryWorkStation(equipmentInt);
        //如果存在工位信息，删除
        if(workStationList.size()>0){
            for(WorkStation workStation: workStationList){
                equipmentMapper.removeWorkStation(workStation.getWorkStationId());
            }
        }
        Equipment equipment = queryEquipment(equipmentInt);
        addOperationLog(equipment,3);
        equipmentMapper.removeEquipment(equipmentInt);
    }

    /**
     * 更新设备
     */
    public void updateEquipment(Equipment equipment) {
        List<WorkStation> workStationList = equipmentMapper.queryWorkStation(equipment.getEquipmentInt());
        //如果存在工位信息，删除
        if(equipment.getWorkStationList() != null){
            for(WorkStation workStation: workStationList){
                equipmentMapper.removeWorkStation(workStation.getWorkStationId());
            }
        }
        Equipment equipment1 = queryEquipment(equipment.getEquipmentInt());
        if (equipment1.getEquipmentName().equals(equipment.getEquipmentName())) {
            addOperationLog(equipment1, 4);
        } else {
            addOperationLog(equipment1, equipment);
        }
        equipmentMapper.updateEquipment(equipment);
        //如果工位不为空，则添加至工位表
        if (equipment.getWorkStationList() != null ) {
            for (WorkStation workStation : equipment.getWorkStationList()) {
                workStation.setEquipmentInt(equipment.getEquipmentInt());
                equipmentMapper.addWorkStation(workStation);
            }
        }

    }

    /**
     * 查询记录数
     */
    public int count(String equipmentId,String equipmentName, String enable, String equipmentInstallLocation, String equipTypeName, String protocolCommunication, String accPointResName, String processName, String createName, String createTime) {
        return equipmentMapper.count(equipmentId, equipmentName ,enable,equipmentInstallLocation, equipTypeName,
                protocolCommunication,accPointResName,processName,createName,createTime);
    }

    /**
     * 批量删除终端
     */
    public void deleteEquipments(List<Integer> equipmentInt) {
        //从表中获取设备的对应工位信息
        for (Integer a: equipmentInt) {
            List<WorkStation> workStationList = equipmentMapper.queryWorkStation(a);
            //如果存在工位信息，删除
            if(workStationList.size()>0){
                for(WorkStation workStation: workStationList){
                    equipmentMapper.removeEquipment(workStation.getWorkStationId());
                }
            }
        }
        for (Integer a:equipmentInt){
            Equipment equipment = queryEquipment(a);
            addOperationLog(equipment,3);
        }
        equipmentMapper.deleteEquipments(equipmentInt);
    }

    /**
     * 检测设备资源号是否存在
     *
     * @param equipmentId 设备资源号
     */
    public int checkEquipmentId(String equipmentId) {
        return equipmentMapper.checkEquipmentId(equipmentId);
    }

    /**
     * 检测设备资源号是否存在
     *
     * @param equipmentId 设备资源号
     */
    public int checkExistence(String equipmentId) {
        return equipmentMapper.checkEquipmentId(equipmentId);
    }


    /**
     * 编辑时检测设备连接IP是否存在，并排除当前设备
     *
     * @param equipmentIp 设备连接Ip
     */
    public int checkEquipmentIp(String equipmentIp,String equipmentInt) {
        return equipmentMapper.checkEquipmentIp(equipmentIp,equipmentInt);
    }

    /**
     * 注册时检测设备连接IP是否存在
     *
     * @param equipmentIp 设备连接Ip
     */
    public int checkIpExistence(String equipmentIp) {
        return equipmentMapper.checkExistenceIp(equipmentIp);
    }

    /**
     * 查询设备对应的工位
     * @param equipmentInt
     * @return
     */
    public Equipment queryWorkStation(int equipmentInt){
        Equipment equipment = new Equipment();
        List<WorkStation> workStationList = equipmentMapper.queryWorkStation(equipmentInt);
        if (workStationList!= null && workStationList.size()>0){
            equipment.setWorkStationList(workStationList);
        }
        return equipment;
    }

    /**
     * 根据设备主键查询设备
     * @param equipmentInt
     * @return
     */
    public Equipment queryEquipment(int equipmentInt){
        Equipment equipment = equipmentMapper.queryEquipment(equipmentInt);
        return equipment;
    }



    /**
     * 设备资产生成操作日志
     * 此处生成增，删，部分改，查询日志操作日志
     */
    public void addOperationLog(Equipment equipment, int a) {
        //获取当前用户信息
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        //创建操作日志对象
        OperationLog operationLog = new OperationLog();
        operationLog.setLogStatus("101");
        operationLog.setResult("101");
        operationLog.setUser(userObject.getUserId());
        operationLog.setOperationTime(new Date());
        switch (a) {
            case 1:
                operationLog.setOperationType("104");
                operationLog.setOperationContent("查询设备");
                break;
            case 2:
                operationLog.setOperationType("101");
                operationLog.setOperationContent("添加设备:"+equipment.getEquipmentName());
                break;
            case 3:
                operationLog.setOperationType("103");
                operationLog.setOperationContent("删除设备:"+equipment.getEquipmentName());
                break;
            case 4:
                operationLog.setOperationType("102");
                operationLog.setOperationContent("修改设备:"+equipment.getEquipmentName());
                break;
        }
        operationLogService.addOperationLog(operationLog);
    }


    /**
     * 生成操作日志
     * 如果修改设备名称，需要指明修改前的设备，故重写此方法
     */
    public void addOperationLog(Equipment equipment1, Equipment equipment2) {
        //获取当前用户信息
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        //创建操作日志对象
        OperationLog operationLog = new OperationLog();
        operationLog.setLogStatus("101");
        operationLog.setResult("101");
        operationLog.setOperationType("102");
        operationLog.setOperationContent("修改设备:将设备" + equipment1.getEquipmentName() + "的名称修改为" + equipment2.getEquipmentName());
        operationLog.setUser(userObject.getUserId());
        operationLog.setOperationTime(new Date());
        operationLogService.addOperationLog(operationLog);
    }

}
