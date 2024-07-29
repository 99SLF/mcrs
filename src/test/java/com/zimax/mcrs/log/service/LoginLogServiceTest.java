package com.zimax.mcrs.log.service;

import com.alibaba.fastjson.JSON;
import com.zimax.cap.common.muo.MyException;
import com.zimax.mcrs.report.controller.BlankingReport;
import com.zimax.mcrs.report.pojo.Blanking;
import com.zimax.mcrs.report.service.BlankingService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.data.redis.RedisProperties;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import redis.clients.jedis.Jedis;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author 施林丰
 * @Date:2024/4/22 17:31
 * @Description
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:springmvc.xml","classpath:applicationContext.xml"})
public class LoginLogServiceTest {
    @Autowired
    private BlankingService blankingService;
   @Test
    public void test(){
      List<Blanking> blankingReportList = blankingService.queryBlankings(null,null,
               null,null,null,null,null,
               null,null,null,null,null,
              null,null,null,null,null);
      List<String> list  = new ArrayList<String>();
      int i=0;
      for(Blanking blanking: blankingReportList){
          list.add(JSON.toJSONString(blanking));
          i++;
          if(i==2){
              System.out.println(list.toArray(new String[0]));
          }
      }
       new Jedis("localhost").rpush("class",list.toArray(new String [0]));
//       System.out.println(blankingService.queryBlankings("1","10",
//               null,null,null,null,null,
//               null,null,null,null,null,
//               null,null,null,null,null));
//       System.out.println("----------------------------------");
   }
   @Test
   public void test1(){
        int x = 5/0;


   }

}
