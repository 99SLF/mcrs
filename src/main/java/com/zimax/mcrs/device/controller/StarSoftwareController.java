package com.zimax.mcrs.device.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.service.StarSoftwareService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 软件自启动
 * @author 林俊杰
 * @date 2022/12/1
 */
@RestController
@ResponseBody
@RequestMapping("/starSoftware")
public class StarSoftwareController {

    @Autowired
    private StarSoftwareService starSoftwareService;

    /**
     * 查询所有设备状态并自启动
     * @param deviceId 设备id
     * @param userName 用户名称
     * @param page 页码
     * @param limit 条数
     *
     * @return StarSoftware
     */
    @GetMapping("/query")
    public Result<?> queryStarSoftware(@RequestParam int deviceId, @RequestParam String userName, int page, int limit ) {
        return Result.success();
    }
}
