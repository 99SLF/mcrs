package com.zimax.cap.utility;

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

}
