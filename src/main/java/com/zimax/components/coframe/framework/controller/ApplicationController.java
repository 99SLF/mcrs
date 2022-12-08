package com.zimax.components.coframe.framework.controller;

import com.zimax.components.coframe.framework.service.ApplicationService;
import com.zimax.mcrs.config.Result;
import com.zimax.components.coframe.framework.pojo.Application;
import net.bytebuddy.implementation.bind.annotation.BindingPriority;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 应用管理
 * @Author 施林丰
 * @Date: 2022-12-1 15:21
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/framework")
public class ApplicationController {

    @Autowired
    ApplicationService applicationService;
    /**
     * 新增应用
     * @param application 应用信息
     */
    @PostMapping("/application/add")
    public Result<?> addApplication(@RequestBody Application application) {
        applicationService.addApplication(application);
        return Result.success();
    }

    /**
     * 更新应用
     * @param application 应用信息
     */
    @PutMapping("/application/update")
    public Result<?> updateApplication(@RequestBody Application application) {
        applicationService.updateApplication(application);
        return Result.success();
    }

    /**
     * 删除应用
     * @param appId 应用信息编号
     */
    @DeleteMapping("/application/delete{appId}")
    public Result<?> deleteApplication(@PathVariable int appId) {
        applicationService.deleteApplication(appId);
        return Result.success();
    }

    /**
     * 查询应用
     * @return 应用列表
     * @param appName 应用名称
     * @param appType 应用类型
     * @param limit 记录数
     * @param page 页码
     * @param field 排序字段
     * @param order 排序方式
     */
    @GetMapping("/application/query")
    public Result<?> queryApplications(String limit,String page, String appName, String appType, String order, String field) {
        List applications = applicationService.queryApplications(page,limit,appName,appType,order,field);
        return Result.success(applications,applicationService.count(appName,appType));
    }

    /**
     * 获取应用信息
     * @param appId 应用编号
     * @return 应用信息
     */
    @GetMapping("/application/find/{appId}")
    public Result<?>  getApplication(@PathVariable("appId") int appId) {
        return Result.success(applicationService.getApplication(appId));
    }

}
