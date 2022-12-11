package com.zimax.mcrs.report.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.report.pojo.AbnProdPrcs;
import com.zimax.mcrs.report.service.AbnProdPrcsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * 生产过程异常报表
 *
 * @author 李伟杰
 * @date 2022/12/5 11:13
 */
@RestController
@RequestMapping("/report")
public class AbnProdPrcsReport {

    /**
     * 生产过程异常服务
     */
    @Autowired
    private AbnProdPrcsService abnProdPrcsService;

    /**
     * 记录生产过程异常报表信息
     *
     * @param abnProdPrcs 生产过程异常
     */
    @PostMapping("/abnProdPrcs/add")
    public Result<?> addAbnProdPrcs(@RequestBody AbnProdPrcs abnProdPrcs) {
        abnProdPrcsService.addAbnProdPrcs(abnProdPrcs);
        return Result.success();
    }


    /**
     * 分页查询所有用户
     *
     * @param page        页记录数
     * @param limit       页码
     * @param siteId      站点号
     * @param rollId      膜卷号
     * @param equipmentId 设备资源号
     * @param axisName    轴名称
     * @param performStep 执行步骤
     * @param createTime  创建时间
     * @param updateTime  更新时间
     * @param order       排序方式
     * @param field       排序字段
     * @return 上料报表信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/abnProdPrcs/query")
    public Result<?> queryAbnProdPrcses(String page, String limit,
                                        String siteId, String rollId,
                                        String equipmentId, String axisName,
                                        String performStep, String createTime,
                                        String updateTime,
                                        String order,String field) {
        List AbnProdPrcses = abnProdPrcsService.queryAbnProdPrcses(page, limit, siteId, rollId, equipmentId, axisName, performStep, createTime, updateTime, order, field);
        return Result.success(AbnProdPrcses, abnProdPrcsService.count(siteId, rollId, equipmentId, axisName, performStep, createTime, updateTime));
    }


}
