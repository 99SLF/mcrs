package com.zimax.components.coframe.framework.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.components.coframe.framework.pojo.Application;
import org.springframework.web.bind.annotation.*;

/**
 * 应用管理
 * @Author 施林丰
 * @Date: 2022-12-1 15:21
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/application")
public class ApplicationController {

    /**
     * 新增应用
     * @param application 应用信息
     */
    @RequestMapping("/add")
    public Result<?> addApplication(@RequestBody Application application) {
        return Result.success();
    }

    /**
     * 更新应用
     * @param application 应用信息
     */
    @RequestMapping("/update")
    public Result<?> updateApplication(@RequestBody Application application) {
        return Result.success();
    }

    /**
     * 删除应用
     * @param appId 应用信息编号
     */
    @DeleteMapping("/delete{appId}")
    public Result<?> removeApplication(@PathVariable int appId) {
        return Result.success();
    }

    /**
     * 查询应用
     * @return 应用列表
     * @param appName 应用名称
     * @param appType 应用类型
     * @param limit 记录数
     * @param page 页码
     */
    @RequestMapping("/query")
    public Result<?> queryApplications(@RequestParam String appName, @RequestParam String appType, @RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }
    /**
     * 获取应用信息
     * @param appId 应用编号
     * @return 角色信息
     */
    @GetMapping("/find/{appId}")
    public Result<?>  getApplication(@PathVariable("appId") int appId) {
        return Result.success();
    }

}
