package com.zimax.components.coframe.framework.startup;

import com.LicenseAuthorization.ClientServices.licenseMatch.LicenseVerify;
import com.zimax.cap.access.http.UserLoginCheckedFilter;
import com.zimax.components.coframe.framework.IFuncResourceService;
import com.zimax.components.coframe.framework.IFunctionService;
import com.zimax.components.coframe.tools.tab.TabPage;
import com.zimax.components.coframe.tools.tab.TabPageManager;
import org.apache.log4j.Logger;
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

    private static final Logger logger = Logger.getLogger(UserLoginCheckedFilter.class);

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {

        try {
            LicenseVerify licenseVerify = new LicenseVerify();
            boolean verifyResult = licenseVerify.verify();
            if (verifyResult){
                ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
                IFunctionService functionService = context.getBean("FunctionBean", IFunctionService.class);
                functionService.initFunctions();

                IFuncResourceService funcResourceService = context.getBean("FuncResourceBean", IFuncResourceService.class);
                funcResourceService.initFuncResources();

                TabPage page = new TabPage();
                page.setTitle("功能");
                page.setUrl("/coframe/framework/function/function_role_auth.jsp");
                page.setOrder(10);
                page.setId("functionGroup");
                TabPageManager.INSTANCE.addTabPage("AuthTab", page);
            }else{
                logger.info("证书无效");
                System.exit(0);
            }
        }catch (Exception e){
            logger.error("证书安装失败！");
            System.exit(0);
        }


    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }

}
