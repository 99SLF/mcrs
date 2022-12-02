package com.zimax.cap.auth.manager;

import com.zimax.cap.auth.AuthResource;
import com.zimax.cap.auth.IAuthPoolManager;
import com.zimax.cap.party.Party;
import com.zimax.cap.party.PartyType;
import com.zimax.cap.party.manager.PartyTypeManager;
import org.apache.log4j.Logger;

import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 权限运行管理
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public class AuthRuntimeManager {

    /**
     * 日志
     */
    private Logger log = Logger.getLogger(AuthRuntimeManager.class);

    /**
     * 锁
     */
    private Object lock = new Object();

    /**
     * 实例
     */
    private static AuthRuntimeManager instance = null;

    /**
     * 授权池管理器
     */
    private IAuthPoolManager authPoolManager = null;

    /**
     * 获取实例
     *
     * @return 实例
     */
    public static AuthRuntimeManager getInstance() {
        if (instance == null) {
            instance = new AuthRuntimeManager();
        }
        return instance;
    }

    /**
     * 获取所有的角色参与者列表
     *
     * @return 角色参与者列表
     */
    public List<Party> getAllRolePartyList() {
        Map<String, PartyType> map = PartyTypeManager.getInstance()
                .getPartyTypeMap();

        Iterator<String> it = map.keySet().iterator();
        while (it.hasNext()) {
            String key = it.next();
            PartyType partyType = map.get(key);
            if (partyType.isRole()) {
                return PartyTypeManager.getInstance()
                        .getPartyTypeDataService(key)
                        .getAllPartyList();
            }
        }
        return Collections.emptyList();
    }

    public List<AuthResource> getAuthResListByRole(Party roleParty) {
        if (roleParty == null) {
            this.log.error("The roleParty is null");
            return Collections.emptyList();
        }
        List<AuthResource> list = this.authPoolManager
                .getAuthResourceList(roleParty);
        if (list == null) {
            synchronized (this.lock) {
                list = this.authPoolManager.getAuthResourceList(roleParty);
                if (list == null) {
                    list = AuthManagerServiceLoader
                            .getCurrentPartyManagerService()
                            .getAuthResListByRole(roleParty);
                    this.authPoolManager.addAuthResourceList(roleParty, list);
                }
            }
        }
        return list;
    }

}
