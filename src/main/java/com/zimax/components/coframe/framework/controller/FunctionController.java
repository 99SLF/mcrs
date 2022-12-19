package com.zimax.components.coframe.framework.controller;

import com.zimax.components.coframe.framework.service.FunctionService;
import com.zimax.mcrs.config.Result;
import com.zimax.components.coframe.framework.pojo.Function;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * @Author 施林丰
 * @Date: 2022-12-1 15:21
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/framework")
public class FunctionController {

    @Autowired
    FunctionService functionService;

    /**
     * 新增功能
     *
     * @param function 功能信息
     */
    @PostMapping("/function/add")
    public Result<?> addFunction(@RequestBody Function function) {
        functionService.addFunction(function);
        return Result.success();
    }

    /**
     * 更新功能
     *
     * @param function 功能信息
     */
    @PutMapping("/function/update")
    public Result<?> updateFunction(@RequestBody Function function) {
        functionService.updateFunction(function);
        return Result.success();
    }
    /**
     * 更新功能
     *
     * @param funcCode 功能代码
     * @param funcName 功能名字
     * @param limit       记录数
     * @param page        页码
     * @param field       排序字段
     * @param order       排序方式
     * @return 功能列表
     */
    @GetMapping("/function/queryByLike")
    public Result<?> queryBylike(String page, String limit, String funcCode, String funcName, String isMenu, String order, String field) {
        List functions = functionService.queryAllFunctionsBylike(page, limit, funcCode, funcName, isMenu,order, field);
        return Result.success(functions, functionService.count(null,isMenu));
    }

    /**
     * 查询功能
     *
     * @param funcGroupId 功能组编号
     * @param funcCode 功能代码
     * @param funcName 功能名字
     * @param limit       记录数
     * @param page        页码
     * @param field       排序字段
     * @param order       排序方式
     * @return 功能列表
     */
    @GetMapping("/function/query")
    public Result<?> queryFunctions(String page, String limit, String funcGroupId, String funcCode, String funcName, String isMenu, String order, String field) {
        List functions = functionService.queryFunctions(page, limit, funcGroupId, funcCode, funcName, isMenu,order, field);
        return Result.success(functions, functionService.count(funcGroupId,isMenu));
    }

    /**
     * 批量删除功能
     *
     * @param funcCodes 角色代码数组
     */
    @DeleteMapping("function/batchDelete")
    public Result<?> deleteFunctions(@RequestBody String[] funcCodes) {
        functionService.deleteFunctions(Arrays.asList(funcCodes));
        return Result.success();
    }
    /**
     * 查询功能
     *
     * @param funcCode 角色代码
     */
    @GetMapping("function/getFunction")
    public Result<?> getFunction(@RequestParam String funcCode) {
        return Result.success(functionService.getFunctionsByCode(funcCode));
    }


}
