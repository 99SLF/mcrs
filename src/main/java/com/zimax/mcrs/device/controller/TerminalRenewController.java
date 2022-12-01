package com.zimax.mcrs.device.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.service.TerminalRenewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@ResponseBody
@RequestMapping("/terminalRenew")
public class TerminalRenewController {

    @Autowired
    private TerminalRenewService terminalRenewService;

    /**
     * 查询全部的设备更新信息
     * @return
     */
    @RequestMapping("/query")
    public Result queryAll() {
        return Result.success();
    }

    /**
     * 上传
     * @return
     */
    @RequestMapping("upload")
    public void upload(){

    }

    /**
     * 导出设备更新信息
     * @return
     */
    @RequestMapping("print")
    public void printTerminalRenew(){

    }

    /**
     * 升级终端
     * @return
     */
    @RequestMapping("upgrade")
    public void upgradeTerminalRenew(){

    }

    /**
     * 回退终端
     * @return
     */
    @RequestMapping("rollback")
    public void rollBackTerminalRenew(){

    }

    /**
     * 依据终端更新编码查询
     * @return
     */
    @RequestMapping("queryTerminalRenewId")
    public void queryTerminalRenewId(){

    }


}
