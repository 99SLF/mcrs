package com.zimax.mcrs.device.controller;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.device.pojo.EquipmentVo;
import com.zimax.mcrs.device.pojo.WorkStation;
import com.zimax.mcrs.device.service.EquipmentService;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.OperationLog;
import com.zimax.mcrs.log.service.InterfaceLogService;
import com.zimax.mcrs.log.service.OperationLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 设备管理
 *
 * @author 林俊杰
 * @date 2022/11/28
 */
@RestController
@RequestMapping("/equipment")
public class EquipmentController {

    //设备服务层
    @Autowired
    private EquipmentService equipmentService;

//    @Autowired InterfaceLogService interfaceLogService;

    /**
     * 查询
     * @param limit 条数
     * @param page 页码
     * @param equipmentId 设备资源号
     * @param equipmentName 设备名称
     * @param enable 是否启用
     * @param equipmentInstallLocation 设备安装位置
     * @param equipTypeName 设备类型名称
     * @param protocolCommunication 支持通信协议
     * @param accPointResName 接入点名称
     * @param processName 工序名称
     * @param createName 创建人
     * @param createTime 创建时间
     * @param order
     * @param field
     * @return
     */
    @GetMapping("/equipment/query")
    public Result<?> query( String limit,  String page, String equipmentId,String equipmentName, String equipmentIp,String enable, String equipmentInstallLocation, String equipTypeName, String protocolCommunication, String accPointResName, String processName, String createName, String createTime,String order, String field) {
        List<EquipmentVo> equipments = equipmentService.queryEquipments(limit, page,equipmentId, equipmentName ,equipmentIp,enable,equipmentInstallLocation, equipTypeName, protocolCommunication,accPointResName,processName,createName,createTime ,order, field);
        List<EquipmentVo> equipments1 = equipmentService.setWorkStation(equipments);
        return Result.success(equipments1, equipmentService.count(equipmentId, equipmentName ,equipmentIp,enable,equipmentInstallLocation, equipTypeName, protocolCommunication,accPointResName,processName,createName,createTime));
    }

    @GetMapping("/equipment/queryByselect")
    public Result<?> queryByselect( String limit,  String page, String equipmentId,String equipmentName, String enable, String equipmentInstallLocation, String equipTypeName, String protocolCommunication, String accPointResName, String processName, String createName, String createTime,String order, String field) {
        List<EquipmentVo> equipments = equipmentService.queryEquipmentsByselect(limit, page,equipmentId, equipmentName ,enable,equipmentInstallLocation, equipTypeName, protocolCommunication,accPointResName,processName,createName,createTime ,order, field);
        List<EquipmentVo> equipments1 = equipmentService.setWorkStation(equipments);
        return Result.success(equipments1, equipmentService.countSelect(equipmentId, equipmentName ,enable,equipmentInstallLocation, equipTypeName, protocolCommunication,accPointResName,processName,createName,createTime));
    }
    /**
     * 添加设备
     *
     * @param equipment 设备信息
     */
    @PostMapping("/equipment/add")
    public Result<?> addEquipment(@RequestBody Equipment equipment) {
        equipmentService.addEquipment(equipment);


//        InterfaceLog interfaceLog = new InterfaceLog();
//        interfaceLog.setEquipmentInt(equipment.getEquipmentInt());
//        interfaceLog.setInterfaceType("101");
//        interfaceLog.setJson(equipment.toString());
//        interfaceLog.setResult("101");
//        interfaceLog.setSource("Web");
//        interfaceLog.setInterfaceName("/equipment/equipment/add");
//        interfaceLogService.addInterfaceLog(interfaceLog);
        return Result.success();
    }

    /**
     * 删除设备
     *
     * @param equipmentInt 设备主键
     */
    @DeleteMapping("/equipment/delete/{equipmentInt}")
    public Result<?> removeEquipment(@PathVariable("equipmentInt") int equipmentInt) {
        equipmentService.removeEquipment(equipmentInt);
        return Result.success();
    }

    /**
     * 更新设备
     *
     * @param equipment 设备信息
     */
    @PostMapping("/equipment/update")
    public Result<?> updateEquipment(@RequestBody Equipment equipment) {
        equipmentService.updateEquipment(equipment);
        return Result.success();
    }

    /**
     * 提供终端信息
     *
     */
    @GetMapping("/equipment/provide")
    public Result<?> provideDevice(){
        return Result.success();
    }

    /**
     * 批量删除设备信息
     *
     * @param equipmentInt 设备主键
     */
    @DeleteMapping("/equipment/batchDelete")
    public Result<?> deleteEquipments(@RequestBody Integer[] equipmentInt) {
        equipmentService.deleteEquipments(Arrays.asList(equipmentInt));
        return Result.success();

    }


    /**
     * 检测设备资源号是否存在
     *
     * @param equipmentId 设备资源号
     */
    @GetMapping("/equipment/check/isExist")
    public Result<?> check(@RequestParam("equipmentId") String equipmentId) {
        if(equipmentService.checkEquipmentId(equipmentId)>0){
            return Result.error("1","当前设备资源号已存在，请输入正确的设备资源号");
        }else {
            return Result.success();
        }
    }


    /**
     * 在编辑页面时候检测设备连接IP是否存在，并且不计算自身
     *
     * @param equipmentIp 设备连接IP
     * @param equipmentInt 设备主键
     */
    @GetMapping("/equipmentIp/check/isExist")
    public Result<?> checkEquipmentIp(@RequestParam("equipmentIp") String equipmentIp,@RequestParam("equipmentInt")String equipmentInt) {
        if(equipmentService.checkEquipmentIp(equipmentIp,equipmentInt)>0){
            return Result.error("1","当前IP已被占用存在，请重新输入正确IP");
        }else {
            return Result.success();
        }
    }


    /**
     * 注册时候检测设备连接IP是否存在
     *
     * @param equipmentIp 设备连接IP
     */
    @GetMapping("/equipmentIp/check/query")
    public Result<?> checkEquipmentIp(@RequestParam("equipmentIp") String equipmentIp) {
        if(equipmentService.checkIpExistence(equipmentIp)>0){
            return Result.error("1","当前IP已被占用存在，请重新输入正确IP");
        }else {
            return Result.success();
        }
    }

    /**
     * 查询设备资产对应的工位信息
     * @param equipmentInt 设备主键
     * @return
     */
    @GetMapping("/equipment/workStation/get")
    public Result<?> getWorkStation(int equipmentInt) {
        return Result.success(equipmentService.queryWorkStation(equipmentInt));
    }

    /**
     * 批量启用
     *
     * @param equipmentInts 设备主键
     */
    @PostMapping("/equipment/enable")
    public Result<?> enable(@RequestBody List<Integer> equipmentInts) {
        equipmentService.enable(equipmentInts);
        return Result.success();

    }

    /**
     * 批量禁用
     *
     * @param equipmentInts 设备主键
     */
    @PostMapping("/equipment/noEnable")
    public Result<?> noEnable(@RequestBody List<Integer> equipmentInts) {
        equipmentService.noEnable(equipmentInts);
        return Result.success();

    }
}
