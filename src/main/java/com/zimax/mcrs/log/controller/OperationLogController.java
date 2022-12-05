package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.service.OperationLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

/**
 * 操作日志
 * @author 林俊杰
 * @date 2022/12/2
 */
@RestController
@ResponseBody
@RequestMapping("/operationLog")
public class OperationLogController {

    @Autowired
    private OperationLogService operationLogService;

    /**
     * 初始化查询
     * @param limit 记录数
     * @param page 页码
     */
    @RequestMapping("/query")
    public Result<?> queryOperationLog( @RequestParam int limit, @RequestParam int page){

        return Result.success();
    }

    /**
     * 条件查询
     * @return
     */
    @GetMapping("/query")
    public Result<?> queryCondition(@RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }

    /**
     * 定时删除
     * @return
     */
    @DeleteMapping("")
    public  Result<?>  deleteOperationLog(@PathVariable("operationTime") Date operationTime) {
        return Result.success();
    }

    /**
     * 通过操作日志id查看操作内容
     * @param operationLogId 操作日志id
     * @return
     */
    @GetMapping("/operationContent")
    public  Result<?>  operationContent(@PathVariable("operationLogId") int operationLogId) {
        return Result.success();
    }

    /**
     * 通过操作日志id查看操作结果
     * @param operationResult 操作日志id
     * @return
     */
    @GetMapping("/operationResult")
    public  Result<?>  operationResult(@PathVariable("operationResult") int operationResult) {
        return Result.success();
    }

}
