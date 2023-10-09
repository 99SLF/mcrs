package com.zimax.components.coframe.framework.startup;

import com.zimax.components.coframe.framework.IFuncResourceService;
import com.zimax.components.coframe.framework.IFunctionService;
import com.zimax.components.coframe.tools.service.ApplicationUtil;
import com.zimax.components.coframe.tools.tab.TabPage;
import com.zimax.components.coframe.tools.tab.TabPageManager;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.util.NumberUtils;

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
        IFunctionService functionService = ApplicationUtil.getInstance().getBean("FunctionBean", IFunctionService.class);
        functionService.initFunctions();

        IFuncResourceService funcResourceService = ApplicationUtil.getInstance().getBean("FuncResourceBean", IFuncResourceService.class);
        funcResourceService.initFuncResources();

        TabPage page = new TabPage();
        page.setTitle("功能");
        page.setUrl("/coframe/framework/function/function_role_auth.jsp");
        page.setOrder(10);
        page.setId("functionGroup");
        TabPageManager.INSTANCE.addTabPage("AuthTab", page);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }

}

