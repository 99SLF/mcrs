package com.zimax.cap.party.manager;

import com.zimax.cap.party.IPartyManagerService;
import com.zimax.cap.party.IPartyUserInitService;
import com.zimax.cap.party.impl.DefaultPartyManagerService;
import com.zimax.cap.party.impl.DefaultPartyUserInitService;

/**
 * 参与者管理服务加载器
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public class PartyManagerServiceLoader {

    /**
     * 当前参与者用户初始化服务
     */
    private static IPartyUserInitService currentPartyUserInitService = null;

    /**
     *
     */
    private static IPartyManagerService currentPartyManagerService = null;

    /**
     * 获取当前参与者用户初始化服务
     *
     * @return 参与者用户初始化服务
     */
    public static IPartyUserInitService getCurrentPartyUserInitService() {
        if (currentPartyUserInitService == null) {
            currentPartyUserInitService = new DefaultPartyUserInitService();
        }
        return currentPartyUserInitService;
    }

    /**
     * 设置当前参与者用户初始化服务
     *
     * @param partyUserInitService 参与者用户初始化服务
     */
    public static void setCurrentPartyUserInitService(
            IPartyUserInitService partyUserInitService) {
        currentPartyUserInitService = partyUserInitService;
    }

    public static IPartyManagerService getCurrentPartyManagerService() {
        if (currentPartyManagerService == null) {
            currentPartyManagerService = new DefaultPartyManagerService();
        }
        return currentPartyManagerService;
    }

    public static void setCurrentPartyManagerService(
            IPartyManagerService partyManagerService) {
        currentPartyManagerService = partyManagerService;
    }
}
