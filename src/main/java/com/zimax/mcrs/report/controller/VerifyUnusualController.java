package com.zimax.mcrs.report.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.report.pojo.CoilDiameterRecord;
import com.zimax.mcrs.report.pojo.VerifyUnusual;
import com.zimax.mcrs.report.service.CoilDiameterRecordService;
import com.zimax.mcrs.report.service.VerifyUnusualService;
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
public class VerifyUnusualController {
    /**
     * 防串度数据记录表服务
     */
    @Autowired
    private VerifyUnusualService verifyUnusualService;

    /**
     * 记录防串度报表信息
     *
     * @param verifyUnusual 报表信息
     */
    @PostMapping("/VerifyUnusual/add")
    public Result<?> addVerifyUnusual(@RequestBody VerifyUnusual verifyUnusual) {
        verifyUnusualService.addVerifyUnusual(verifyUnusual);
        return Result.success();
    }

    /**
     * 分页查询所有防串度数据记录表信息
     *
     * @param page       页记录数
     * @param limit      页码
     * @param resource   设备资源号
     * @param axisName   轴名称
     * @param rfidReader 读写器ID
     * @param antenna    天线
     * @param processLot 已读取标签值
     * @param tag        替换的标签值
     * @param readNum    读取到的次数
     * @param sfcPre     生产SFC
     * @param sfc        拆分后SFC
     * @param startTime  开始时间
     * @param endTime    结束时间
     * @param order      排序方式
     * @param field      排序字段
     * @return RFID报表信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/VerifyUnusual/query")
    public Result<?> queryVerifyUnusual(String page, String limit,
                                        String resource, String axisName,
                                        String rfidReader, String antenna,
                                        String processLot, String tag,
                                        String readNum, String sfcPre,
                                        String sfc,
                                        String startTime, String endTime,
                                        String order, String field) {
        List VerifyUnusual = verifyUnusualService.queryVerifyUnusual(page, limit, resource, axisName, rfidReader, antenna, processLot, tag, readNum, sfcPre, sfc, startTime, endTime, order, field);
        return Result.success(VerifyUnusual, verifyUnusualService.count(resource, axisName, rfidReader, antenna, processLot, tag, readNum, sfcPre, sfc, startTime, endTime));
    }
}
