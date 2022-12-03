package com.zimax.cap.access.http;

import javax.servlet.http.HttpServletRequest;

/**
 * HTTP帮助类
 *
 * @author 苏尚文
 * @date 2022/12/3 15:25
 */
public class HttpHelper {

    /**
     *获取远程地址
     *
     * @param request 请求对象
     * @return 远程地址
     */
    public static String getRemoteAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}
