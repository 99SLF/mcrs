package com.zimax.cap.party.impl;

import com.zimax.cap.party.IUserObject;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * 用户对象
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public class UserObject implements IUserObject, Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 用户编号
     */
    private String userId;

    /**
     * 用户名称
     */
    private String userName;

    /**
     * 用户邮箱
     */
    private String userMail;

    /**
     * 用户真实姓名
     */
    private String userRealName;

    private String userOrgId;

    private String userOrgName;

    private String userRemoteIp;

    /**
     * 唯一编号
     */
    private String uniqueId;

    private String sessionId;

    public UserObject() {
        this.uniqueId = UUID.randomUUID().toString().replace("-", "");
    }

    @Override
    public String getUserId() {
        return this.userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Override
    public String getUserMail() {
        return this.userMail;
    }

    public void setUserMail(String userMail) {
        this.userMail = userMail;
    }

    @Override
    public String getUserName() {
        return this.userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String getUserOrgId() {
        return this.userOrgId;
    }

    public void setUserOrgId(String userOrgId) {
        this.userOrgId = userOrgId;
    }

    @Override
    public String getUserOrgName() {
        return this.userOrgName;
    }

    public void setUserOrgName(String userOrgName) {
        this.userOrgName = userOrgName;
    }

    @Override
    public String getUserRealName() {
        return this.userRealName;
    }

    public void setUserRealName(String userRealName) {
        this.userRealName = userRealName;
    }

    @Override
    public String getUniqueId() {
        return this.uniqueId;
    }

    public void setUniqueId(String uniqueId) {
        this.uniqueId = uniqueId;
    }

    @Override
    public String getUserRemoteIp() {
        return this.userRemoteIp;
    }

    public void setUserRemoteIp(String userRemoteIp) {
        this.userRemoteIp = userRemoteIp;
    }

    @Override
    public Object clone()
            throws CloneNotSupportedException {
        UserObject user = (UserObject) super.clone();


        Map<String, Object> clonedAttributes = new HashMap();
        clonedAttributes.putAll(getAttributes());

        user.setAttributes(clonedAttributes);

        return user;
    }

    public UserObject shallowClone() {
        UserObject cloned = new UserObject();
        cloned.setSessionId(getSessionId());
        cloned.setUniqueId(getUniqueId());
        cloned.setUserId(getUserId());
        cloned.setUserMail(getUserMail());
        cloned.setUserName(getUserName());
        cloned.setUserOrgId(getUserOrgId());
        cloned.setUserOrgName(getUserOrgName());
        cloned.setUserRealName(getUserRealName());
        cloned.setUserRemoteIp(getUserRemoteIp());

        return cloned;
    }

    private Map<String, Object> attributes = new HashMap();

    public boolean contains(String key) {
        return this.attributes.containsKey(key);
    }

    public Object get(String key) {
        return this.attributes.get(key);
    }

    public Map<String, Object> getAttributes() {
        return this.attributes;
    }

    public void put(String key, Object value) {
        this.attributes.put(key, value);
    }

    public Object remove(String key) {
        return this.attributes.remove(key);
    }

    public void setAttributes(Map<String, Object> attributes) {
        if (attributes == null) {
            return;
        }
        this.attributes = attributes;
    }

    public void clear() {
        this.attributes.clear();
    }

    @Override
    public String getSessionId() {
        return this.sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }
}
