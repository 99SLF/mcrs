package com.zimax.mcrs.report.mapper;

import com.zimax.mcrs.report.pojo.AbnProdPrcs;
import com.zimax.mcrs.report.pojo.Blanking;
import org.apache.ibatis.annotations.Mapper;

/**
 * 生产过程异常报表
 * @author 李伟杰
 * @date 2022/12/8 19:28
 */
@Mapper
public interface AbnProdPrcsReportMapper {

    /**
     * 添加报表信息
     * @param abnProdPrcs 生产过程异常报表
     * @return
     */
    void addAbnProdPrcs(AbnProdPrcs abnProdPrcs);

}
