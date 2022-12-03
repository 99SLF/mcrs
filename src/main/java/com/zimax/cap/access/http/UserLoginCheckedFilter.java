package com.zimax.cap.access.http;

import com.zimax.cap.exception.CapRuntimeException;
import com.zimax.cap.party.IUserObject;
import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 用户登录检查过滤器
 *
 * @author 苏尚文
 * @date 2022/12/3 10:48
 */
public class UserLoginCheckedFilter implements Filter {

    private static final Logger logger = Logger.getLogger(UserLoginCheckedFilter.class);

    private static boolean portal;

    private static String[] excludeUrls = new String[0];

    private static String[] includeUrls = new String[0];

    private static String errorPage;

    public static String getErrorPage() {
        return errorPage;
    }

    public static void setErrorPage(String errorPage) {
        if ((errorPage != null) && (errorPage.length() > 0)) {
            int oldLength = excludeUrls.length;
            String[] newExcludeUrls = new String[oldLength + 1];
            for (int i = 0; i < oldLength; i++) {
                newExcludeUrls[i] = excludeUrls[i];
            }
            newExcludeUrls[oldLength] = errorPage;
            excludeUrls = newExcludeUrls;
        }
        UserLoginCheckedFilter.errorPage = errorPage;
    }

    public static String[] getExcludeUrls() {
        return excludeUrls;
    }

    public static void setExcludeUrls(String excludeUrls) {
        UserLoginCheckedFilter.excludeUrls = excludeUrls == null ? new String[0]
                : excludeUrls.split(",");
        for (String exclude : UserLoginCheckedFilter.excludeUrls) {
            if (exclude.endsWith("/*")) {
                logger.warn("The exclude pattern '" + exclude
                        + "' is dangerous.");
            }
        }
    }

    public static boolean isPortal() {
        return portal;
    }

    public static void setPortal(boolean portal) {
        UserLoginCheckedFilter.portal = portal;
    }

    public static String[] getIncludeUrls() {
        return includeUrls;
    }

    public static void setIncludeUrls(String includeUrls) {
        UserLoginCheckedFilter.includeUrls = includeUrls == null ? new String[0]
                : includeUrls.split(",");
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpServletResponse httpRep = (HttpServletResponse) response;
        boolean isLogin = isLogin(httpReq, httpRep);
        if (isLogin == true) {
            chain.doFilter(request, response);
            return;
        }
        String servletPath = HttpUrlHelper.getRequestUrl(httpReq, httpRep);
        if (logger.isDebugEnabled()) {
            logger.debug("checked url [" + servletPath + "] is exclude ?");
        }
        boolean isExcludeUrl = HttpUrlHelper.isIn(servletPath, excludeUrls);
        if (isExcludeUrl == true) {
            chain.doFilter(request, response);
            return;
        }
        if (HttpUrlHelper.isIn(servletPath, includeUrls)) {
            if (logger.isTraceEnabled()) {
                logger.error("access url [" + servletPath + "] must be login.");
            }
            ExceptionObject exObj = new ExceptionObject(httpReq);
            exObj.setInvalid(true);
            exObj.setForwardPage(errorPage);
            exObj.setThrowable(new CapRuntimeException("12101001"));

            ThrowableProcessHelper.execute(httpReq, httpRep, exObj, true);
        } else {
            chain.doFilter(request, response);
            return;
        }
    }

    public void destroy() {
    }

    private boolean isLogin(HttpServletRequest httpReq,
                            HttpServletResponse httpRep) {
        HttpSession session = httpReq.getSession(false);
        if (session == null) {
            return false;
        }
        boolean isLogin = false;
        if ((session.getAttribute("userObject") != null)
                && (!(session.getAttribute("userObject") instanceof IUserObject))) {
            throw new CapRuntimeException("12101011", new String[] {
                    IUserObject.class.getName(),
                    session.getAttribute("userObject").getClass().getName() });
        }
        IUserObject userObject = (IUserObject) session
                .getAttribute("userObject");
        if (userObject != null
                && OnlineUserManager.getUserObjectsByUniqueId(userObject
                .getUniqueId()) != null) {
            isLogin = true;
        }
        return isLogin;
    }
}
