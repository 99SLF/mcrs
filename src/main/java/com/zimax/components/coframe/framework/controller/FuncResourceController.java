package com.zimax.components.coframe.framework.controller;

import com.zimax.components.coframe.framework.service.FuncResourceService;
import com.zimax.mcrs.config.Result;
import com.zimax.components.coframe.framework.pojo.FuncResource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 功能资源管理
 *
 * @Author 施林丰
 * @Date: 2022-12-1 15:21
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/framework")
public class FuncResourceController {
    @Autowired
    FuncResourceService funcResourceService;

    /**
     * 新增功能资源
     *
     * @param funcresource 功能资源信息
     */
    @PostMapping("/funcResource/add")
    public Result<?> addFuncResource(@RequestBody FuncResource funcresource) {
        funcResourceService.addFuncResource(funcresource);
        return Result.success();
    }

    /**
     * 更新功能资源
     *
     * @param funcResource 功能资源信息
     */
    @PutMapping("/funcResource/update")
    public Result<?> updateFuncResource(@RequestBody FuncResource funcResource) {
        funcResourceService.updateFuncResource(funcResource);
        return Result.success();
    }

    /**
     * 查询功能资源
     *
     * @param funcCode 功能编号
     * @param limit    记录数
     * @param page     页码
     * @param field    排序字段
     * @param order    排序方式
     * @return 应用列表
     */
    @GetMapping("/funcResource/query")
    public Result<?> queryFuncresource(String page, String limit, String funcCode, String order, String field) {
        List funcResources = funcResourceService.queryFuncResources(page, limit, funcCode, order, field);
        return Result.success(funcResources, funcResourceService.count(funcCode));
    }

    /**
     * 批量删除功能
     *
     * @param resIds 资源代码数组
     */
    @DeleteMapping("/funcResource/batchDelete")
    public Result<?> deleteFuncResources(@RequestBody Integer[] resIds) {
        funcResourceService.deleteFuncResources(Arrays.asList(resIds));
        return Result.success();
    }
}
