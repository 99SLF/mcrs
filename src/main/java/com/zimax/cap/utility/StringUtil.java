package com.zimax.cap.utility;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * 字符串工具类
 *
 * @author 苏尚文
 * @date 2022/12/2 16:50
 */
public final class StringUtil {

    private static final String[] EMPTY_STRING_ARRAY = new String[0];

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

    public static String substringAfter(String str, String separator) {
        if (isEmpty(str)) {
            return str;
        }
        if (separator == null) {
            return "";
        }
        int pos = str.indexOf(separator);
        if (pos == -1) {
            return "";
        }
        return str.substring(pos + separator.length());
    }

    public static boolean isNotEmpty(String str) {
        return (str != null) && (str.length() > 0);
    }

    public static String[] split(String str, char separatorChar) {
        return splitWorker(str, separatorChar, false);
    }

    private static String[] splitWorker(String str, char separatorChar,
                                        boolean preserveAllTokens) {
        if (str == null) {
            return null;
        }
        int len = str.length();
        if (len == 0) {
            return EMPTY_STRING_ARRAY;
        }
        List list = new ArrayList();
        int i = 0;
        int start = 0;
        boolean match = false;
        boolean lastMatch = false;
        while (i < len) {
            if (str.charAt(i) == separatorChar) {
                if ((match) || (preserveAllTokens)) {
                    list.add(str.substring(start, i));
                    match = false;
                    lastMatch = true;
                }
                i++;
                start = i;
            } else {
                lastMatch = false;

                match = true;
                i++;
            }
        }
        if ((match) || ((preserveAllTokens) && (lastMatch))) {
            list.add(str.substring(start, i));
        }
        return (String[]) list.toArray(new String[list.size()]);
    }

    public static String substringBefore(String str, String separator) {
        if ((isEmpty(str)) || (separator == null)) {
            return str;
        }
        if (separator.length() == 0) {
            return "";
        }
        int pos = str.indexOf(separator);
        if (pos == -1) {
            return str;
        }
        return str.substring(0, pos);
    }

    public static boolean equalsIgnoreCase(String str1, String str2) {
        return str1 == null ? false : str2 == null ? true : str1
                .equalsIgnoreCase(str2);
    }

}
