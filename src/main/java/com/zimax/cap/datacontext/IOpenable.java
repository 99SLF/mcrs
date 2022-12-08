package com.zimax.cap.datacontext;

import java.util.Map;

/**
 * @author 苏尚文
 * @date 2022/12/6 14:35
 */
public interface IOpenable {

    void setAttributes(Map<String, Object> paramMap);

    Map<String, Object> getAttributes();

    void put(String paramString, Object paramObject);

    Object get(String paramString);

    boolean contains(String paramString);

    Object remove(String paramString);

    void clear();
}
