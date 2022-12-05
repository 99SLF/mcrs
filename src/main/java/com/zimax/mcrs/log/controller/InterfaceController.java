package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.service.InterfaceLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

/**
 * 接口日志管理
 * @author 林俊杰
 * @date 2022/12/2
 */
@RestController
@RequestMapping("/interface")
public class InterfaceController {
    /**
     * 接口日志管理
     */
    @Autowired
    private InterfaceLogService interfaceLogService;


    /**
     * 定时删除接口日志
     * @param operationTime  操作时间
     */
    @DeleteMapping("/{operationTime}")
    public  Result<?>  removeInterfaceLog(@PathVariable("operationTime")int operationTime) {
        return Result.success();
    }

    /**
     * 初始化查询
     *
     */
    @GetMapping("/find")
    public Result<?> queryAll(){
        return null;
    }

    /**
     * 条件查询接口日志
     * @param operationTime 操作时间
     * @param interfaceName 接口名称
     * @param interfaceLogStatus 日志状态
     * @param operator 操作人
     * @param operationRole 操作角色
     * @param limit 记录数
     * @param page 页码
     * @return 角色列表
     */
    @GetMapping("/query")
    public Result<?> select(@RequestParam Date operationTime, @RequestParam String interfaceName, @RequestParam String interfaceLogStatus, @RequestParam String operator, @RequestParam String operationRole, @RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }



//    /**
//     * 依据接口日志id查询正常日志
//     * @param interfaceLogId  操作日志Id
//     * @return
//     */
//    @GetMapping("/find/{interfaceLogId}")
//    public Result<?> queryNormalLog(@PathVariable("interfaceLogId")int interfaceLogId){
//        return Result.success();
//    }

//    /**
//     * 依据接口日志id查询异常日志
//     * @param interfaceLogId  操作日志Id
//     * @return
//     */
//    @GetMapping("/find/{interfaceLogId}")
//    public Result<?> queryUnusualLog(@PathVariable("interfaceLogId")int interfaceLogId){
//        return Result.success();
//    }


}
