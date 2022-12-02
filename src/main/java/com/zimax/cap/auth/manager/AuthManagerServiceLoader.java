package com.zimax.cap.auth.manager;

import com.zimax.cap.auth.IAuthManagerService;

/**
 * 授权管理服务加载器
 *
 * @author 苏尚文
 * @date 2022/12/2 15:19
 */
public class AuthManagerServiceLoader {

    private static IAuthManagerService currentAuthManagerService = null;

    public static IAuthManagerService getCurrentPartyManagerService() {
        return currentAuthManagerService;
    }

    public static void setCurrentPartyManagerService(
            IAuthManagerService authManagerService) {
        currentAuthManagerService = authManagerService;
    }
}
