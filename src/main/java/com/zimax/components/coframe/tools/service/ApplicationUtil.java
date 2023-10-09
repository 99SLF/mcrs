package com.zimax.components.coframe.tools.service;

import com.zimax.cap.management.resource.manager.ResourceConfigurationManager;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * @Author 施林丰
 * @Date:2023/8/15 16:16
 * @Description 上下文内容
 */
public  class ApplicationUtil {
    private static volatile ApplicationContext applicationContext = null;
    public static ApplicationContext getInstance() {
        if (applicationContext == null) {
            synchronized (ApplicationUtil.class){
                if(applicationContext==null){
                    applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
                }
            }
        }
        return applicationContext;
    }
}
