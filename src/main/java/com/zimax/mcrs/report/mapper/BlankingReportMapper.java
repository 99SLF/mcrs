package com.zimax.mcrs.report.mapper;

import com.zimax.mcrs.report.pojo.Blanking;
import org.apache.ibatis.annotations.Mapper;

/**
 * 下料报表
 * @author 李伟杰
 * @date 2022/12/8 19:28
 */
@Mapper
public interface BlankingReportMapper {

    /**
     * 添加报表信息
     * @param blanking 下料报表
     * @return
     */
    void addBlanking(Blanking blanking);
}
