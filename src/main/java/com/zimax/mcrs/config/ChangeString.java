package com.zimax.mcrs.config;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Author 施林丰
 * @Date:2022/12/6 21:50
 * @Description
 */
    /**
     * 驼峰转化下划线
     */
public class ChangeString {
    public  String camelUnderline(String line){
        if(line==null||"".equals(line)){
            return "";
        }
        String separator = "_";
        line = line.replaceAll("([a-z])([A-Z])", "$1"+separator+"$2").toLowerCase();
        return line;
    }
}
