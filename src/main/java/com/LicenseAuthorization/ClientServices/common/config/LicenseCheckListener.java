package com.LicenseAuthorization.ClientServices.common.config;

import com.LicenseAuthorization.license.entity.License;
import com.LicenseAuthorization.ClientServices.licenseMatch.LicenseVerify;
import com.LicenseAuthorization.license.entity.LicenseVerifyParam;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * @author 李伟杰
 * @date 2023/3/3 16:32
 */
public class LicenseCheckListener implements ServletContextListener {


    private License license = (License) new ClassPathXmlApplicationContext(
            "applicationContext.xml").getBean("License");
    String subject = license.getSubject();
    String publicAlias = license.getPublicAlias();
    String storePass = license.getStorePass();
    String licensePath = license.getLicensePath();
    String publicKeysStorePath = license.getPublicKeysStorePath();

    @Override
    public void contextInitialized(ServletContextEvent event) {
        if (StringUtils.isNotBlank(licensePath)) {
            System.out.println("++++++++ 开始安装证书 ++++++++");

            LicenseVerifyParam param = new LicenseVerifyParam();
            param.setSubject(subject);
            param.setPublicAlias(publicAlias);
            param.setStorePass(storePass);
            param.setLicensePath(licensePath);
            param.setPublicKeysStorePath(publicKeysStorePath);

            LicenseVerify licenseVerify = new LicenseVerify();
            //安装证书
            licenseVerify.install(param);


            System.out.println("++++++++ 证书安装结束 ++++++++");
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
