package com.zimax.mcrs.report.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.report.pojo.Blanking;
import com.zimax.mcrs.report.service.BlankingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 下料报表
 * @author 李伟杰
 * @date 2022/12/5 10:59
 */
@RestController
@RequestMapping("/report")
public class BlankingReport {

    /**
     *下料报表服务
     */
    @Autowired
    private BlankingService blankingService;

    /**
     * 记录下料报表信息
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
     * @param page     页记录数
     * @param limit    页码
     * @param equipmentId   设备资源号
     * @param axisName       轴名称
     * @param antennaLoc    天线位置
     * @param prodSFCId 生产SFC编码
     * @param isEnd     是否完工
     * @param startProdTime    开始生产时间
     * @param endProdTime 结束生产时间
     * @param order    排序方式
     * @param field    排序字段
     * @return 上料报表信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/blanking/query")
    public Result<?> queryBlankings(String page,  String limit,
                                   String equipmentId, String axisName,
                                   String antennaLoc, String prodSFCId,
                                   String isEnd, String startProdTime,
                                   String endProdTime,
                                   String order, String field) {
        List blankings = blankingService.queryBlankings(page,limit,equipmentId,axisName,antennaLoc,prodSFCId,isEnd,startProdTime,endProdTime,order,field);
        return Result.success(blankings,blankingService.count(equipmentId,axisName,antennaLoc,prodSFCId,isEnd,startProdTime,endProdTime));
    }
}
