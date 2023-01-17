package com.zimax.mcrs.device.controller;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.device.service.EquipmentService;
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

    @Autowired
    private EquipmentService equipmentService;

    /**
     * 查询
     *
     * @param equipmentId   设备资源号
     * @param equipmentName 设备名称
     * @param enable        启用
     * @param processName 工序名称
     * @param limit         记录数
     * @param page          页码
     * @param field         排序字段
     * @param order         排序方式
     * @return 设备列表
     */
    @GetMapping("/equipment/query")
    public Result<?> query( String limit,  String page, String equipmentId, String equipmentName,String enable, String processName,String order, String field) {
        List equipments = equipmentService.queryEquipments(limit, page, equipmentId, equipmentName,enable,processName ,order, field);
        return Result.success(equipments, equipmentService.count(equipmentId, equipmentName,enable,processName));
    }

    /**
     * 添加设备
     *
     * @param equipment 设备信息
     */
    @PostMapping("/equipment/add")
    public Result<?> addEquipment(@RequestBody Equipment equipment) {
//        //获取当前用户信息
//        IUserObject userName = DataContextManager.current().getMUODataContext().getUserObject();
//        System.out.println("=============================================================");
//        System.out.println(userName);
        //设置创建人为当前用户的姓名
//        equipment.setCreator(creator.get());
//        //设置创建日期为当前时间
//        equipment.setCreateTime(new Date());
        //调用方法添加设备
        equipmentService.addEquipment(equipment);
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
     * 检测设备连接IP是否存在
     *
     * @param equipmentIp 设备连接IP
     */
    @GetMapping("/equipmentIp/check/isExist")
    public Result<?> checkEquipmentIp(@RequestParam("equipmentIp") String equipmentIp) {
        if(equipmentService.checkEquipmentIp(equipmentIp)>0){
            return Result.error("1","当前IP已被占用存在，请重新输入正确IP");
        }else {
            return Result.success();
        }
    }



}
