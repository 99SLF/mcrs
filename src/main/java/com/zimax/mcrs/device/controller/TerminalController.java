package com.zimax.mcrs.device.controller;


import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Terminal;
import com.zimax.mcrs.device.service.TerminalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 终端管理
 * @author 林俊杰
 * @date 2022/11/30
 */
@RestController
@ResponseBody
@RequestMapping("/terminal")
public class TerminalController {

    @Autowired
    private TerminalService terminalService;

    /**
     * 注册终端
     * @param terminal 终端
     */
    @RequestMapping("/registrationTerminal")
    public Result<?> registrationTerminal(@RequestBody Terminal terminal) {
        terminalService.registrationTerminal(terminal);
        return  Result.success();
    }

    /**
     * 注销终端
     * @param APPID 依据APPDId来注销终端
     */
    @DeleteMapping("/logoutTerminal/{APPId}")
    public Result<?> logoutTerminal(@PathVariable("APPId")int APPID) {
//        terminalService.logoutById(APPID);
        return Result.success();
    }

    /**
     * 查询终端
     * @param APPID 依据APPDId来查询终端
     */
    @GetMapping("/find/{APPId}")
    public Result<?> getTerminalAPPId(@PathVariable("APPId") int APPID) {

        return Result.success(terminalService.queryAPPId(APPID));
    }

    /**
     * 查询终端
     * @param deviceId 依据设备资源号来查询终端
     */
    @GetMapping("/find/{deviceId}")
    public Result<?> getTerminalDeviceId(@PathVariable("deviceId") int deviceId) {

        return Result.success(terminalService.queryDeviceId(deviceId));
    }

    /**
     * 查询终端
     * @param terminalType 依据设备软件类型来查询终端
     */
    @GetMapping("/find/{terminalType}")
    public Result<?> getTerminalType(@PathVariable("terminalType") String terminalType) {

        return Result.success(terminalService.queryTerminalType(terminalType));
    }

    /**
     * 初始化查询
     * @param APPId APPId
     * @param deviceId 设备资源号
     * @param limit 记录数
     * @param page 页码
     */
    @GetMapping("/query}")
    public Result<?> queryTerminal(int APPId, int deviceId, int page, int limit) {

        return Result.success(terminalService.queryAll());
    }
}
