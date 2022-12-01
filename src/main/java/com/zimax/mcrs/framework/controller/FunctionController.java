package com.zimax.mcrs.framework.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.framework.pojo.Funcresource;
import com.zimax.mcrs.framework.pojo.Function;
import org.springframework.web.bind.annotation.*;

/**
 * @Author 施林丰
 * @Date: 2022/12/1/
 * @Description
 */
public class FunctionController {

    /**
     * 新增功能
     * @param function 功能信息
     */
    @RequestMapping("/add")
    public Result<?> addFunction(@RequestBody Function function) {
        return Result.success();
    }

    /**
     * 更新功能
     * @param function 功能信息
     */
    @RequestMapping("/update")
    public Result<?> updateFunction(@RequestBody Function function) {
        return Result.success();
    }


    /**
     * 查询功能
     * @return 功能列表
     * @param funcGroupId 功能组编号
     * @param limit 记录数
     * @param page 页码
     */
    @RequestMapping("/query")
    public Result<?> queryFuncresource(@RequestParam String funcGroupId, @RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }

}
