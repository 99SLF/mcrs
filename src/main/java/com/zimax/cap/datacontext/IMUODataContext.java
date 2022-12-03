package com.zimax.cap.datacontext;

import com.zimax.cap.party.IUserObject;

/**
 * MUO数据环境
 *
 * @author 苏尚文
 * @date 2022/12/3 12:01
 */
public interface IMUODataContext {

    String[] getManagedKeys();

    boolean[] keysIsChanged();

    IUserObject getUserObject();
}
