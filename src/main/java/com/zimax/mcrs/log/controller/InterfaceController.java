package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.service.InterfaceLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
     * 查询全部接口日志
     * @param interfaceLogId 接口日志Id
     * @param interfaceName 接口日志名称
     * @param limit 记录数
     * @param page 页码
     * @return 角色列表
     */
    @GetMapping()
    public Result<?> queryAll(@RequestParam int interfaceLogId, @RequestParam String interfaceName, @RequestParam int limit, @RequestParam int page){
        return null;
    }

    /**
     * 定时删除接口日志
     * @param operationTime  操作时间
     */
    @DeleteMapping("/{operationTime}")
    public  Result<?>  deleteInterfaceLog(@PathVariable("operationTime")int operationTime) {
        return Result.success();
    }

    /**
     * 依据条件查询接口日志
     *
     */
    @GetMapping("/find")
    public Result<?> query(){
        return null;
    }

    /**
     * 依据接口日志id查询正常日志
     * @param interfaceLogId  操作日志Id
     * @return
     */
    @GetMapping("/find/{interfaceLogId}")
    public Result<?> queryNormalLog(@PathVariable("interfaceLogId")int interfaceLogId){
        return Result.success();
    }

    /**
     * 依据接口日志id查询异常日志
     * @param interfaceLogId  操作日志Id
     * @return
     */
    @GetMapping("/find/{interfaceLogId}")
    public Result<?> queryUnusualLog(@PathVariable("interfaceLogId")int interfaceLogId){
        return Result.success();
    }


}
