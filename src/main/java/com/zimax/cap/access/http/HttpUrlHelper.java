package com.zimax.cap.access.http;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * HTTP地址帮助类
 *
 * @author 苏尚文
 * @date 2022/12/3 9:29
 */
public class HttpUrlHelper {

    /**
     * 获取请求地址
     *
     * @param httpReq 请求对象
     * @param httpRep 响应对象
     * @return 请求地址
     */
    public static String getRequestUrl(HttpServletRequest httpReq, HttpServletResponse httpRep) {
        String servletPath = (String) httpReq.getAttribute("javax.servlet.include.servlet_path");
        if (servletPath == null) {
            servletPath = httpReq.getServletPath();
            String pathInfo = httpReq.getPathInfo();
            if (pathInfo != null) {
                servletPath = servletPath + pathInfo;
            }
        } else {
            String includedPathInfo = (String) httpReq.getAttribute("javax.servlet.include.path_info");
            if (includedPathInfo != null) {
                servletPath = servletPath + includedPathInfo;
            }
        }
        return servletPath;
    }

    /**
     * 是否在已有的地址数组中
     *
     * @param requestUrl 请求地址
     * @param urls  地址数组
     * @return 是否在
     */
    public static boolean isIn(String requestUrl, String[] urls) {
        boolean isIncludeUrl = false;
        for (String includeUrl : urls) {
            if (matchFiltersURL(includeUrl, requestUrl) == true)
            {
                isIncludeUrl = true;
                break;
            }
        }
        return isIncludeUrl;
    }

    public static boolean matchFiltersURL(String pattern, String requestPath)
    {
        if (requestPath == null) {
            return false;
        }
        if (pattern == null) {
            return false;
        }
        if (pattern.startsWith("*."))
        {
            int slash = requestPath.lastIndexOf('/');
            int period = requestPath.lastIndexOf('.');
            if ((slash >= 0) && (period > slash) && (period != requestPath.length() - 1) && (requestPath.length() - period == pattern.length() - 1)) {
                return pattern.regionMatches(2, requestPath, period + 1, pattern.length() - 2);
            }
        }
        if (pattern.equals(requestPath)) {
            return true;
        }
        if (pattern.equals("/*")) {
            return true;
        }
        if (pattern.endsWith("/*"))
        {
            if (pattern.regionMatches(0, requestPath, 0, pattern.length() - 2))
            {
                if (requestPath.length() == pattern.length() - 2) {
                    return true;
                }
                if ('/' == requestPath.charAt(pattern.length() - 2)) {
                    return true;
                }
            }
            return false;
        }
        if ((pattern.startsWith(".")) &&
                (requestPath.endsWith(pattern))) {
            return true;
        }
        if (pattern.startsWith("**/"))
        {
            int slash = requestPath.lastIndexOf('/');
            if (pattern.substring(3).equals(requestPath.substring(slash + 1))) {
                return true;
            }
        }
        int idx = pattern.indexOf("/**.");
        if (idx >= 0)
        {
            int leftLength = idx;

            int rightLength = pattern.length() - leftLength - 3;
            if (pattern.regionMatches(0, requestPath, 0, leftLength)) {
                return requestPath.regionMatches(requestPath.length() - rightLength, pattern, pattern.length() - rightLength, rightLength);
            }
        }
        return false;
    }
}
