package com.LicenseAuthorization.ClientServices.common.config;

import com.LicenseAuthorization.ClientServices.licenseMatch.LicenseVerify;
import com.alibaba.fastjson.JSON;
import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/3/3 16:10
 *  @Description: 拦截器配置（Spring方式）
 */
public class LicenseCheckedFilter implements Filter {

    private static final Logger logger = Logger.getLogger(LicenseCheckedFilter.class);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        logger.info("进入拦截器，验证证书可使用性");
        LicenseVerify licenseVerify = new LicenseVerify();

        //校验证书是否有效
        boolean verifyResult = licenseVerify.verify();

        if(verifyResult){
            logger.info("验证成功，证书可用");
            chain.doFilter(servletRequest, response);
            return;
        }else{
            logger.info("验证失败，证书无效");
            response.setCharacterEncoding("utf-8");
            Map<String,String> result = new HashMap<>(1);
            result.put("权限：","您的证书无效，请核查服务器是否取得授权或重新申请证书！");

            response.getWriter().write(JSON.toJSONString(result));
        }

    }

    @Override
    public void destroy() {

    }
}
