package com.zimax.cap.party.impl;

import com.zimax.cap.party.IUserObject;

/**
 * 用户对象
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public class UserObject implements IUserObject {

    /**
     * 唯一编号
     */
    private String uniqueId;

    /**
     * 用户编号
     */
    private String userId;

    @Override
    public String getUniqueId() {
        return uniqueId;
    }

    /**
     * 获取唯一编号
     *
     * @param uniqueId 唯一编号
     */
    public void setUniqueId(String uniqueId) {
        this.uniqueId = uniqueId;
    }

    @Override
    public String getUserId() {
        return userId;
    }

    /**
     * 设置用户编号
     *
     * @param userId 用户编号
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

}
