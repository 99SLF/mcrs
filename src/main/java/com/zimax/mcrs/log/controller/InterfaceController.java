package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.log.pojo.DeviceExchangeLogVo;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.InterfaceLogVo;
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
     * @param equipmentId 设备资源号
     * @param invokerName 调用者
     * @param interfaceType 接口类型
     * @param limit         记录数
     * @param page          页码
     * @param field         排序字段
     * @param order         排序方式
     * @return 设备列表
     */
    @GetMapping("/interfaceLog/query")
    public Result<?> query(String limit, String page,  String source,String equipmentId,String equipmentName,String interfaceType,String result,
                           String invokerName,String disposeTime,String interfaceName,String createTime ,String order, String field) {
        List interfaceLogs = interfaceLogService.queryInterfaceLog(limit, page, source, equipmentId,equipmentName ,interfaceType,result,invokerName,disposeTime,interfaceName,createTime,order, field);
        return Result.success(interfaceLogs, interfaceLogService.count(source, equipmentId,equipmentName ,interfaceType,result,invokerName,disposeTime,interfaceName,createTime));
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
     * 使用POST方式查询日志给CS端
     */
    @PostMapping("/interfaceLog/CSquery")
    public Result<?> csQuery(@RequestBody InterfaceLogVo interfaceLogVo) {
        List interfaceLogs = interfaceLogService.csQuery(interfaceLogVo.getAPPId());
        return Result.success(interfaceLogs);
    }


}
