package com.zimax.components.coframe.init;

import com.zimax.cap.party.impl.UserObject;
import com.zimax.cap.party.manager.PartyManagerServiceLoader;

/**
 * 用户对象初始化
 *
 * @author 苏尚文
 * @date 2022/12/3 11:39
 */
public class UserObjectInit {

    /**
     * 用户对象实例
     */
    public static final UserObjectInit INSTANCE = new UserObjectInit();

    private UserObjectInit() {
    }

    /**
     * 初始化用户对象
     *
     * @param userId 用户编号
     */
    public UserObject init(String userId) {
        return (UserObject) PartyManagerServiceLoader
                .getCurrentPartyUserInitService().initUserObject(userId);
    }

}
