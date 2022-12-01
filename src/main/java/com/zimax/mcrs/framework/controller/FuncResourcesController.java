package com.zimax.mcrs.framework.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.framework.pojo.Funcgroup;
import com.zimax.mcrs.framework.pojo.Funcresource;
import org.springframework.web.bind.annotation.*;

/**
 * 功能资源管理
 * @Author 施林丰
 * @Date: 2022/12/1/
 * @Description
 */
public class FuncResourcesController {

    /**
     * 新增功能资源
     * @param funcresource 功能资源信息
     */
    @RequestMapping("/add")
    public Result<?> addFuncresource(@RequestBody Funcresource funcresource) {
        return Result.success();
    }

    /**
     * 更新功能资源
     * @param funcresource 功能资源信息
     */
    @RequestMapping("/update")
    public Result<?> updateFuncresource(@RequestBody Funcresource funcresource) {
        return Result.success();
    }

    /**
     * 删除功能资源
     * @param resId 功能资源编号
     */
    @DeleteMapping("/delete{resId}")
    public Result<?> removeFuncresource(@PathVariable int resId) {
        return Result.success();
    }

    /**
     * 查询功能资源
     * @return 应用列表
     * @param funcCode 功能编号
     * @param limit 记录数
     * @param page 页码
     */
    @RequestMapping("/query")
    public Result<?> queryFuncresource(@RequestParam String funcCode, @RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }

}
