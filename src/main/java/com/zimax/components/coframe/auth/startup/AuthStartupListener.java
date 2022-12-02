package com.zimax.components.coframe.auth.startup;

import com.zimax.cap.auth.manager.AuthRuntimeManager;
import com.zimax.cap.party.Party;
import com.zimax.cap.party.manager.PartyManagerServiceLoader;
import com.zimax.components.coframe.init.CoframePartyUserInitService;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.List;

/**
 * 组织权限管理启动监听器
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public class AuthStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        // 初始化，主要是为了让授权池作为监听器注册到可授权资源池
        AuthRuntimeManager.getInstance();

        PartyManagerServiceLoader
                .setCurrentPartyUserInitService(new CoframePartyUserInitService());

        // 提升登录性能，将角色资源映射加载出来
        List<Party> rolePartyList = AuthRuntimeManager.getInstance()
                .getAllRolePartyList();
        for (Party roleParty : rolePartyList) {
            AuthRuntimeManager.getInstance().getAuthResListByRole(roleParty);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }

}
