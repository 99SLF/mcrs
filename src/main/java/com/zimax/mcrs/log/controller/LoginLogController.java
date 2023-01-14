package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.LoginLog;
import com.zimax.mcrs.log.service.InterfaceLogService;
import com.zimax.mcrs.log.service.LoginLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 登录日志管理
 * @author 林俊杰
 * @date 2023/1/11
 */
@RestController
@RequestMapping("/log")
public class LoginLogController {

    @Autowired
    private LoginLogService loginLogService;


    /**
     *
     * @param limit     条数
     * @param page  页码
     * @param equipmentId   设备资源号
     * @param source    来源
     * @param loginUser     登录用户
     * @param loginTime     登录事件
     * @param order
     * @param field
     * @return
     */
    @GetMapping("/loginLog/query")
    public Result<?> query(String limit, String page, String equipmentId, String source, String loginUser, String loginTime, String order, String field) {
        List loginLogs = loginLogService.queryLoginLogLog(limit, page, equipmentId, source,loginUser ,loginTime,order, field);
        return Result.success(loginLogs, loginLogService.count(equipmentId,source,loginUser,loginTime));
    }

    /**
     * 添加登录日志
     *
     * @param loginLog 登录日志信息
     */
    @PostMapping("/loginLog/add")
    public Result<?> addLoginLog(@RequestBody LoginLog loginLog) {
        loginLogService.addLoginLog(loginLog);
        return Result.success();
    }


    /**
     * 删除接口日志
     *
     * @param loginLogId 根据登录日志主键删除
     */
    @DeleteMapping("/loginLog/delete/{loginLogId}")
    public Result<?> removeLoginLog(@PathVariable("loginLogId") int loginLogId){
        System.out.println(loginLogId);
        loginLogService.removeLoginLog(loginLogId);
        return Result.success();
    }

}
