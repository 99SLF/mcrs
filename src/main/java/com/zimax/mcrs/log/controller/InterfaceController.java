package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.service.InterfaceLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

/**
 * 接口日志管理
 * @author 林俊杰
 * @date 2022/12/2
 */
@RestController
@RequestMapping("/log")
public class InterfaceController {
    /**
     * 接口日志管理
     */
    @Autowired
    private InterfaceLogService interfaceLogService;


    /**
     * 查询
     *
     * @param createTime   创建时间
     * @param source  来源
     * @param interfaceName 接口名称
     * @param equipmentIp 设备Ip
     * @param invokerName 调用者
     * @param interfaceType 接口类型
     * @param limit         记录数
     * @param page          页码
     * @param field         排序字段
     * @param order         排序方式
     * @return 设备列表
     */
    @GetMapping("/interfaceLog/query")
    public Result<?> query(String limit, String page, String createTime, String source, String interfaceType,String equipmentIp, String invokerName, String interfaceName ,String order, String field) {
        List interfaceLogs = interfaceLogService.queryInterfaceLog(limit, page, createTime, source,interfaceType ,equipmentIp,invokerName,interfaceName,order, field);
        return Result.success(interfaceLogs, interfaceLogService.count(createTime, source,interfaceType ,equipmentIp,invokerName,interfaceName));
    }



    /**
     * 检测设备是否存在
     *
     * @param equipmentInt 设备资源号
     */
    @GetMapping()
    public Result<?> checkInterface(@RequestParam("equipmentInt") int equipmentInt) {
        if(interfaceLogService.checkEquipment(equipmentInt)>0){
            return Result.success();
        }else {
            return Result.error("1","设备不存在，请先注册设备");
        }

    }

    /**
     * 添加接口日志
     *
     * @param interfaceLog 接口日志信息
     */
    @PostMapping("/interfaceLog/add")
    public Result<?> addInterfaceLog(@RequestBody InterfaceLog interfaceLog) {
//        checkInterface(interfaceLog.getEquipmentInt());
        interfaceLogService.addInterfaceLog(interfaceLog);
        return Result.success();
    }


    /**
     * 删除接口日志
     *
     * @param interfaceLogId 依据接口日志主键删除
     */
    @DeleteMapping("/interfaceLog/delete/{interfaceLogId}")
    public Result<?> removeInterfaceLog(@PathVariable("interfaceLogId") int interfaceLogId){
        interfaceLogService.removeInterfaceLog(interfaceLogId);
        return Result.success();
    }

}
