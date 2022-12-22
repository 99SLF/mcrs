package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.pojo.OperationLog;
import com.zimax.mcrs.log.service.OperationLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

/**
 * 操作日志
 * @author 林俊杰
 * @date 2022/12/2
 */
@RestController
@ResponseBody
@RequestMapping("/log")
public class OperationLogController {

    @Autowired
    private OperationLogService operationLogService;

    /**
     * 条件查询接口日志
     * @param logStatus 日志状态
     * @param operationType 操作类型
     * @param operationTime 日志创建时间
     * @param operationResult 操作结果
     * @param operator 操作人
     * @param limit 记录数
     * @param page 页码
     * @return 操作日志列表
     */
    @GetMapping("/operationLog/query")
    public Result<?> queryOperationLog(String limit, String page, String logStatus, String operationType, String operationTime,String operationResult, String operator,String order, String field) {
        List operationLogs = operationLogService.queryOperationLog(limit,page,logStatus,operationType,operationTime,operationResult,operator,order,field);
        return Result.success(operationLogs, operationLogService.count(logStatus));
    }

    /**
     * 添加操作日志
     * @param operationLog 操作日志
     */
    @PostMapping("/operationLog/add")
    public Result<?> addOperationLog(@RequestBody OperationLog operationLog){
        operationLogService.addOperationLog(operationLog);
        return Result.success();
    }


    /**
     * 删除功能
     *
     * @param operationLogId 依据操作日志主键删除
     */
    @DeleteMapping("/operationLog/delete/{operationLogId}")
    public Result<?> removeOperationLog(@PathVariable("operationLogId") int operationLogId) {
        operationLogService.removeOperationLog(operationLogId);
        return Result.success();
    }




}
