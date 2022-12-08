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
    FunctionService  functionService;
    /**
     * 新增功能
     * @param function 功能信息
     */
    @PostMapping("/function/add")
    public Result<?> addFunction(@RequestBody Function function) {
        functionService.addFunction(function);
        return Result.success();
    }

    /**
     * 更新功能
     * @param function 功能信息
     */
    @PutMapping("/function/update")
    public Result<?> updateFunction(@RequestBody Function function) {
        functionService.updateFunction(function);
        return Result.success();
    }

    /**
     * 查询功能
     * @return 功能列表
     * @param funcGroupId 功能组编号
     * @param limit 记录数
     * @param page 页码
     * @param field 排序字段
     * @param order 排序方式
     */
    @GetMapping("/function/query")
    public Result<?> queryFunctions(String page, String limit, String funcGroupId, String order, String field) {
        List functions = functionService.queryFunctions(page,limit,funcGroupId,order,field);
        return Result.success(functions,functionService.count(funcGroupId));
    }

    /**
     * 批量删除功能
     * @param funcCodes 角色代码数组
     */
    @DeleteMapping("function/batchDelete")
    public Result<?> deleteFunctions(@RequestBody String[] funcCodes) {
        if(functionService.deleteFunctions(Arrays.asList(funcCodes))==0){
            return Result.success();
        }else{
            return Result.error("1","删除失败");
        }

    }

}
