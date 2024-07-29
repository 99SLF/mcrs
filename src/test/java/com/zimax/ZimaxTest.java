package com.zimax;

import com.zimax.mcrs.report.mapper.BlankingReportMapper;
import com.zimax.mcrs.report.pojo.Blanking;
import com.zimax.mcrs.report.service.BlankingService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;

/**
 * @Author 施林丰
 * @Date:2024/4/22 17:12
 * @Description
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:springmvc.xml","classpath:applicationContext.xml"})
public class ZimaxTest{
    @Autowired
    private BlankingService blankingService;
    @Test
    public   void test(){
        System.out.println(blankingService.queryBlankings("1","10",
                null,null,null,null,null,
                null,null,null,null,null,
                null,null,null,null,null));
        System.out.println("----------------------------------");
     }
}
