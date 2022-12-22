package com.zimax.mcrs.device.controller;

import com.zimax.components.coframe.framework.pojo.Application;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.PointDispose;
import com.zimax.mcrs.device.service.PointDisposeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author 施林丰
 * @Date:2022/12/21 9:45
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/pointdispose")
public class PointDisposeController {
    @Autowired
    PointDisposeService pointDisposeService;
    /**
     * 新增点位
     *
     * @param pointDispose 点位信息
     */
    @PostMapping("/add")
    public Result<?> addPoint(@RequestBody PointDispose pointDispose) {
        pointDisposeService.addPoint(pointDispose);
        return Result.success();
    }

    /**
     * 查询点位
     *
     * @param deviceName 终端名称
     * @param limit   记录数
     * @param page    页码
     * @param field   排序字段
     * @param order   排序方式
     * @return 应用列表
     */
    @GetMapping("/queryAll")
    public Result<?> queryPointdisPoses(String limit, String page, String deviceName, String order, String field) {
            List pointDisposes = pointDisposeService.queryPointDisposes(page, limit, deviceName, order, field);
        return Result.success(pointDisposes, pointDisposeService.count(deviceName));
    }
    @GetMapping("/get")
    public Result<?> getPointDispose(String appId) {
        return Result.success(pointDisposeService.getPointDispose(appId));
    }
}
