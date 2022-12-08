package com.zimax.components.coframe.framework.startup;

import com.zimax.components.coframe.framework.IFuncResourceService;
import com.zimax.components.coframe.framework.IFunctionService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 应用功能启动监听器
 *
 * @author 苏尚文
 * @date 2022/12/7 11:54
 */
public class FunctionStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        IFunctionService functionService = context.getBean("FunctionBean", IFunctionService.class);
        functionService.initFunctions();

        IFuncResourceService funcResourceService = context.getBean("FuncResourceBean", IFuncResourceService.class);
        funcResourceService.initFuncResources();
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }

}
