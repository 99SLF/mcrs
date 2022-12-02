package com.zimax.components.coframe.framework.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.components.coframe.framework.pojo.Funcgroup;
import org.springframework.web.bind.annotation.*;


/**
 * 功能组管理
 * @Author 施林丰
 * @Date: 2022-12-1 15:21
 * @Description
 */
public class FuncGroupController {

    /**
     * 新增功能组
     * @param funcgroup 功能组信息
     */
    @RequestMapping("/add")
    public Result<?> addFuncGroup(@RequestBody Funcgroup funcgroup) {
        return Result.success();
    }

    /**
     * 更新功能组
     * @param funcgroup 功能组信息
     */
    @RequestMapping("/update")
    public Result<?> updateFuncGroup(@RequestBody Funcgroup funcgroup) {
        return Result.success();
    }

    /**
     * 删除功能组
     * @param funcGroupId 应用功能组编号
     */
    @DeleteMapping("/delete{funcGroupId}")
    public Result<?> removeFuncGroup(@PathVariable int funcGroupId) {
        return Result.success();
    }

    /**
     * 查询功能组
     * @return 功能组列表
     * @param appId 应用编号
     * @param limit 记录数
     * @param page 页码
     */
    @RequestMapping("/query")
    public Result<?> queryFuncGroups(@RequestParam int appId, @RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }

}
