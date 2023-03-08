package com.zimax.mcrs.report.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.report.pojo.Blanking;
import com.zimax.mcrs.report.service.BlankingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 下料报表
 *
 * @author 李伟杰
 * @date 2022/12/5 10:59
 */
@RestController
@RequestMapping("/report")
public class BlankingReport {

    /**
     * 下料报表服务
     */
    @Autowired
    private BlankingService blankingService;

    /**
     * 记录下料报表信息
     *
     * @param blanking 下料报表信息
     */
    @PostMapping("/blanking/add")
    public Result<?> addBlanking(@RequestBody Blanking blanking) {
        blankingService.addBlanking(blanking);
        return Result.success();
    }

    /**
     * 分页查询所有用户
     *
     * @param page             页记录数
     * @param limit            页码
     * @param resource         设备资源号
     * @param operation        轴名称
     * @param axis             天线位置
     * @param sfcPre           载具码
     * @param processLot       生产SFC编码
     * @param sfc              是否完工
     * @param qty              开始生产时间
     * @param metre            结束生产时间
     * @param diamRealityValue 是否完工
     * @param createdBy        开始生产时间
     * @param updatedBy        结束生产时间
     * @param startTime        开始时间
     * @param endTime          结束时间
     * @param order            排序方式
     * @param field            排序字段
     * @return 上料报表信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/blanking/query")
    public Result<?> queryBlankings(String page, String limit,
                                    String resource, String operation,
                                    String axis, String sfcPre,
                                    String processLot, String sfc,
                                    String qty, String metre,
                                    String diamRealityValue, String createdBy,
                                    String updatedBy,
                                    String startTime, String endTime,
                                    String order, String field) {
        List blankings = blankingService.queryBlankings(page, limit, resource, operation, axis, sfcPre, processLot, sfc, qty, metre, diamRealityValue, createdBy, updatedBy, startTime, endTime, order, field);
        return Result.success(blankings, blankingService.count(resource, operation, axis, sfcPre, processLot, sfc, qty, metre, diamRealityValue, createdBy, updatedBy, startTime, endTime));
    }
}
