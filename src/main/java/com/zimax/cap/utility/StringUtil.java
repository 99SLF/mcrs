package com.zimax.cap.utility;

import java.text.MessageFormat;

/**
 * 字符串工具类
 *
 * @author 苏尚文
 * @date 2022/12/2 16:50
 */
public final class StringUtil {

    /**
     * 是否为空
     *
     * @param str 字符串
     * @return 是否为空
     */
    public static boolean isEmpty(String str) {
        return str == null || str.length() == 0;
    }

    /**
     * 格式化字符串
     *
     * @param s
     * @param params
     * @return
     */
    public static String format(String s, Object[] params) {
        String message = s;
        if (message == null) {
            return "";
        }
        if ((params != null) && (params.length > 0)) {
            message = new MessageFormat(message).format(params);
        }
        return message;
    }

    public static boolean isNullOrBlank(String str) {
        if ((isNull(str)) || (str.equals("")) || (str.equals("null"))) {
            return true;
        }
        return false;
    }

    public static boolean isNull(String str) {
        if ((str == null) || (str.trim().length() == 0)) {
            return true;
        }
        return false;
    }

}
