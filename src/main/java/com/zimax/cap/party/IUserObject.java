package com.zimax.cap.party;

/**
 * 用户对象接口
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public interface IUserObject {

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

    /**
     * 获取用户编号
     *
     * @return 用户编号
     */
    String getUserId();

}
