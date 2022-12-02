package com.zimax.cap.party.impl;

import com.zimax.cap.party.IPartyUserInitService;
import com.zimax.cap.party.IUserObject;

/**
 * 默认参与者用户初始化服务
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public class DefaultPartyUserInitService implements IPartyUserInitService {

    @Override
    public IUserObject initUserObject(String userId) {
        UserObject userObject = new UserObject();
        userObject.setUserId(userId);
        return userObject;
    }
}
