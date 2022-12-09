package com.zimax.mcrs.report.service;

import com.zimax.mcrs.report.mapper.AbnProdPrcsReportMapper;
import com.zimax.mcrs.report.pojo.AbnProdPrcs;
import com.zimax.mcrs.report.pojo.Feeding;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 李伟杰
 * @date 2022/12/5 15:17
 */
@Service
public class AbnProdPrcsService {
    @Autowired
    private AbnProdPrcsReportMapper abnProdPrcsReportMapper;

    /**
     * 添加上料报表信息
     * @param abnProdPrcs 上料报表
     */
    public void addAbnProdPrcs(AbnProdPrcs abnProdPrcs){

        abnProdPrcsReportMapper.addAbnProdPrcs(abnProdPrcs);
    }

}
