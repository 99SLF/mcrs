package com.zimax.mcrs.report.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.report.pojo.CoilDiameterRecord;
import com.zimax.mcrs.report.pojo.Feeding;
import com.zimax.mcrs.report.service.CoilDiameterRecordService;
import com.zimax.mcrs.report.service.FeedingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author 施林丰
 * @Date:2023/3/4 13:29
 * @Description
 */
@RestController
@RequestMapping("/report")
public class CoilDiameterRecordController {
    /**
     * 上下料卷径数据记录表服务
     */
    @Autowired
    private CoilDiameterRecordService coilDiameterRecordService;

    /**
     * 记录上下料卷径报表信息
     *
     * @param coilDiameterRecord 报表信息
     */
    @PostMapping("/CoilDiameterRecord/add")
    public Result<?> addCoilDiameterRecord(@RequestBody CoilDiameterRecord coilDiameterRecord) {
        coilDiameterRecordService.addCoilDiameterRecord(coilDiameterRecord);
        return Result.success();
    }


    /**
     * 分页查询所有上下料卷径报表信息
     *
     * @param page              页记录数
     * @param limit             页码
     * @param resource          设备资源号
     * @param sfcPreData        放卷SFC
     * @param uDiamRealityValue 放卷卷径
     * @param rAxisName         收卷轴名称
     * @param rProcessLotPre    收卷载具号
     * @param sfcData           收卷SFC
     * @param rDiamRealityValue 收卷卷径
     * @param isLastVolume      是否最后一卷
     * @param unwindIsOver      放卷物料是否消耗完成
     * @param remark            放卷异常信息记录
     * @param startTime         开始时间
     * @param endTime           结束时间
     * @param order             排序方式
     * @param field             排序字段
     * @return RFID报表信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/CoilDiameterRecord/query")
    public Result<?> queryCoilDiameterRecord(String page, String limit,
                                             String resource, String sfcPreData,
                                             String uDiamRealityValue, String rAxisName,
                                             String rProcessLotPre, String sfcData,
                                             String rDiamRealityValue, String isLastVolume,
                                             String unwindIsOver, String remark,
                                             String startTime, String endTime,
                                             String order, String field) {
        List CoilDiameter = coilDiameterRecordService.queryCoilDiameterRecord(page, limit,  resource,  sfcPreData, uDiamRealityValue,  rAxisName, rProcessLotPre,  sfcData, rDiamRealityValue,  isLastVolume, unwindIsOver,  remark, startTime, endTime, order, field);
        return Result.success(CoilDiameter, coilDiameterRecordService.count(resource,  sfcPreData, uDiamRealityValue,  rAxisName, rProcessLotPre,  sfcData, rDiamRealityValue,  isLastVolume, unwindIsOver,  remark, startTime, endTime));
    }
}
