package com.zimax.cap.common.muo.impl;

import com.zimax.cap.common.muo.mbean.SessionManagerConfigModel;
import com.zimax.cap.party.IUserObject;

import java.util.HashMap;
import java.util.Map;

/**
 * @author 苏尚文
 * @date 2022/12/7 9:47
 */
public class MUOConfig {

    private static MUOConfig instance = new MUOConfig();

    private static Map<String, IUserObject> virtualUserObjects = new HashMap();

    public static MUOConfig getInstance() {
        return instance;
    }

    private SessionManagerConfigModel model = new SessionManagerConfigModel();

    public SessionManagerConfigModel getModel() {
        return this.model;
    }

    public void setModel(SessionManagerConfigModel model) {
        this.model = model;
    }

    public void addVirtualUserObject(String userType, IUserObject userObject) {
        virtualUserObjects.put(userType, userObject);
    }

    public void removeVirtualUserObject(String userType) {
        virtualUserObjects.remove(userType);
    }

    public void removeVirtualUserObjects() {
        virtualUserObjects.clear();
    }

    public IUserObject getVirtualUserObject(String userType) {
        return (IUserObject) virtualUserObjects.get(userType);
    }
}
