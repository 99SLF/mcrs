package com.zimax.cap.party;

import java.io.Serializable;

/**
 * 用户对象接口
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public interface IUserObject extends Serializable, Cloneable {

    /**
     * 环境中的关键字
     */
    String KEY_IN_CONTEXT = "userObject";

    /**
     * 获取唯一编号
     *
     * @return 唯一编号
     */
    String getUniqueId();

    String getSessionId();

    /**
     * 获取用户编号
     *
     * @return 用户编号
     */
    String getUserId();

    String getUserMail();

    String getUserName();

    String getUserOrgId();

    String getUserOrgName();

    String getUserRealName();

    String getUserRemoteIp();

    Object clone() throws CloneNotSupportedException;
}
