package com.zimax.cap.datacontext;

import java.io.Serializable;

/**
 * 基础数据环境接口
 *
 * @author 苏尚文
 * @date 2022/12/6 10:20
 */
public interface IBaseDataContext extends Cloneable, Serializable {

    Object getRootObject();

//    Object createObject(String xpath, Class<?> clazz);

//    DataObject createObject(String xpath, Type type);

//    void deleteObject(String xpath);

    Object get(String xpath);

//    Object get(String xpath, Class<?> targetClass);

    void set(String xpath, Object value);

    void set(String xpath, Object obj, Class<?> targetType);

    void add(String xpath, Object obj);

    Object clone() throws CloneNotSupportedException;

    String getName();

    void setName(String name);

    void setType(String type);

    String getType();
}
