package com.zimax.mcrs.report.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.report.pojo.RFIDReadRa;
import com.zimax.mcrs.report.service.RFIDReadRaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * RFID读取率报表
 *
 * @author 李伟杰
 * @date 2022/12/5 11:17
 */
@RestController
@RequestMapping("/report")
public class RFIDReadRaReport {

    /**
     * RFID读取率报表服务
     */
    @Autowired
    private RFIDReadRaService rfidReadRaService;

    /**
     * 记录RFID读取率报表信息
     *
     * @param rfidReadRa RFID读取率报表信息
     */
    @PostMapping("/rfidReadRa/add")
    public Result<?> addRFIDReadRa(@RequestBody RFIDReadRa rfidReadRa) {
        rfidReadRaService.addRFIDReadRa(rfidReadRa);
        return Result.success();
    }

    /**
     * 分页查询所有rfid的内容
     *
     * @param page      页记录数
     * @param limit     页码
     * @param epcId     载具号
     * @param readNum   读取次数
     * @param reader    RFID读写器
     * @param antenna   RFID天线
     * @param dBm       天线增益
     * @param rssi      RSSI
     * @param startTime 开始时间
     * @param endTime   结束时间
     * @param order     排序方式
     * @param field     排序字段
     * @return RFID报表信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/rfidReadRa/query")
    public Result<?> queryRFIDs(String page, String limit,
                                String epcId, String readNum,
                                String reader, String antenna,
                                String dBm, String rssi, String startTime, String endTime,
                                String order, String field) {
        List RFIDs = rfidReadRaService.queryRFIDs(page, limit, epcId, readNum, reader, antenna, dBm, rssi, startTime, endTime, order, field);
        return Result.success(RFIDs, rfidReadRaService.count(epcId, readNum, reader, antenna, dBm, rssi, startTime, endTime));
    }
}
