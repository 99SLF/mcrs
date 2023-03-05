package com.zimax.mcrs.report.service;

import com.zimax.mcrs.report.mapper.RFIDReadRaReportMapper;
import com.zimax.mcrs.report.mapper.VerifyUnusualMapper;
import com.zimax.mcrs.report.pojo.RFIDReadRa;
import com.zimax.mcrs.report.pojo.VerifyUnusual;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author 施林丰
 * @Date:2023/3/4 13:38
 * @Description
 */
@Service
public class VerifyUnusualService {
    /**
     * 防串度记录报表
     */
    @Autowired
    private VerifyUnusualMapper verifyUnusualMapper;


    /**
     * 添加防串度读取率报表信息
     *
     * @param verifyUnusual 防串读取率报表
     */
    public void addVerifyUnusual(VerifyUnusual verifyUnusual) {
        verifyUnusualMapper.addVerifyUnusual(verifyUnusual);
    }
}
