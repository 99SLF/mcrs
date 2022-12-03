package com.zimax.cap.datacontext;

import com.zimax.cap.party.IUserObject;

import java.util.Map;

/**
 * SESSION映射
 *
 * @author 苏尚文
 * @date 2022/12/3 11:56
 */
public interface ISessionMap {

    /**
     * 获取用户对象
     *
     * @return 用户对象
     */
    IUserObject getUserObject();

    Object getRootObject();

}
