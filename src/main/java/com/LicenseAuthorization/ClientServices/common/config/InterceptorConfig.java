package com.LicenseAuthorization.ClientServices.common.config;

/**
 * @author 李伟杰
 * @date 2023/3/17 21:43
 */


import com.LicenseAuthorization.ClientServices.licenseMatch.LicenseCheckInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.annotation.Resource;

/**
 * @Description: 拦截器配置（SpringBoot）
 */
@Configuration
public class InterceptorConfig implements WebMvcConfigurer {


    @Resource
    LicenseCheckInterceptor licenseCheckInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        //添加要拦截的url
        registry.addInterceptor(licenseCheckInterceptor).addPathPatterns("/**");// 拦截的路径

        registry.addInterceptor(licenseCheckInterceptor).excludePathPatterns("/admin/login");// 放行的路径
    }
}