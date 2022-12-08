package com.zimax.mcrs.report.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.report.pojo.RFIDReadRa;
import com.zimax.mcrs.report.service.RFIDReadRaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * RFID读取率报表
 * @author 李伟杰
 * @date 2022/12/5 11:17
 *
 */
@RestController
@RequestMapping("/report")
public class RFIDReadRaReport {

    /**
     *RFID读取率报表服务
     */
    @Autowired
    private RFIDReadRaService rfidReadRaService;

    /**
     * 记录RFID读取率报表信息
     * @param rfidReadRa RFID读取率报表信息
     */
    @PostMapping("/rfidReadRa/add")
    public Result<?> addRFIDReadRa(@RequestBody RFIDReadRa rfidReadRa) {
        rfidReadRaService.addRFIDReadRa(rfidReadRa);
        return Result.success();
    }
}
