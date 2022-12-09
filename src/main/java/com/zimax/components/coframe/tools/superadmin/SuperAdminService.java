package com.zimax.components.coframe.tools.superadmin;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.datacontext.IMUODataContext;
import com.zimax.cap.party.IUserObject;

/**
 * 超级管理员辅助类，判断当前用户是否是超级管理员
 *
 * @author 苏尚文
 * @date 2022/12/9 14:39
 */
public class SuperAdminService {

    private static final String SUPER_USER_ID = "sysadmin";

    /**
     * 如果用户名是sysadmin则认为是超级管理员
     *
     * @return
     */
    public static boolean currUserIsSupserAdmin() {
        IMUODataContext muoContext = DataContextManager.current().getMUODataContext();
        IUserObject userObject = muoContext.getUserObject();
        if (userObject != null) {
            return SUPER_USER_ID.equals(userObject.getAttributes().get("EXTEND_USER_ID"));
        }
        return false;
    }
}
