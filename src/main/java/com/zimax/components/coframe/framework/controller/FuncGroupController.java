package com.zimax.components.coframe.framework.controller;

import com.zimax.components.coframe.framework.service.FuncGroupService;
import com.zimax.mcrs.config.Result;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import net.bytebuddy.implementation.bind.annotation.BindingPriority;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


/**
 * 功能组管理
 * @Author 施林丰
 * @Date: 2022-12-1 15:21
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/funcGroup")
public class FuncGroupController {
    @Autowired
    FuncGroupService funcGroupService;
    /**
     * 新增功能组
     * @param funcgroup 功能组信息
     */
    @GetMapping("/add")
    public Result<?> addFuncGroup(@RequestBody FuncGroup funcgroup) {
        funcGroupService.addFuncGroup(funcgroup);
        return Result.success();
    }

    /**
     * 更新功能组
     * @param funcgroup 功能组信息
     */
    @PutMapping("/update")
    public Result<?> updateFuncGroup(@RequestBody FuncGroup funcgroup) {
        funcGroupService.updatefuncGroup(funcgroup);
        return Result.success();
    }

    /**
     * 删除功能组
     * @param funcGroupId 应用功能组编号
     */
    @DeleteMapping("/delete{funcGroupId}")
    public Result<?> removeFuncGroup(@PathVariable int funcGroupId) {
        funcGroupService.deletefuncGroup(funcGroupId);
        return Result.success();
    }

    /**
     * 查询功能组
     * @return 功能组列表
     * @param appId 应用编号
     * @param limit 记录数
     * @param page 页码
     * @param field 排序字段
     * @param order 排序方式
     */
    @GetMapping("/query")
    public Result<?> queryFuncGroups(@RequestParam int page, @RequestParam int limit, int appId, String order, String field) {
        List funcGroups = funcGroupService.queryFuncGroups(page,limit,appId,order,field);
        return Result.success(funcGroups,funcGroupService.count(appId));
    }

    /**
     * 获取功能组信息
     * @param funcGroupId 功能组编号
     * @return 功能组信息
     */
    @GetMapping("/find/{funcGroupId}")
    public Result<?>  getFuncGroup(@PathVariable("funcGroupId") int funcGroupId) {
        return Result.success(funcGroupService.getfuncGroup(funcGroupId));
    }
}
