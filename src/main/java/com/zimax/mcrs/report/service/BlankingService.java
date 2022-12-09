package com.zimax.mcrs.report.service;
import com.zimax.mcrs.report.mapper.BlankingReportMapper;
import com.zimax.mcrs.report.pojo.Blanking;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 李伟杰
 * @date 2022/12/5 15:17
 */
@Service
public class BlankingService {

    @Autowired
    private BlankingReportMapper blankingReportMapper;

    /**
     * 添加下料报表信息
     * @param blanking 下料报表
     */
    public void addBlanking(Blanking blanking){

        blankingReportMapper.addBlanking(blanking);
    }
}
