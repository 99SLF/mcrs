package com.zimax.cap.auth.manager;

import com.alibaba.excel.util.StringUtils;
import com.zimax.cap.auth.AuthResource;
import com.zimax.cap.auth.IAuthPoolManager;
import com.zimax.cap.cache.CacheFactory;
import com.zimax.cap.cache.CacheProperty;
import com.zimax.cap.cache.ICache;
import com.zimax.cap.party.Party;

import java.util.ArrayList;
import java.util.List;

/**
 * 授权池管理器
 *
 * @author 苏尚文
 * @date 2022/12/6 16:59
 */
public class AuthPoolManager implements IAuthPoolManager {

    private ICache<Party, List<AuthResource>> authResourceMap = null;

    public static final String AUTH_CACHE_NAME = "com.zimax.cap.auth.auth.cache";

    public AuthPoolManager() {
        this.authResourceMap = (ICache<Party, List<AuthResource>>) CacheFactory
                .getInstance().findCache(AUTH_CACHE_NAME);
        if (this.authResourceMap == null) {
//            String cluserName = DomainManager.getInstance().getCurrentServer()
//                    .getGroupName();
//            if (StringUtils.isBlank(cluserName)) {
                CacheProperty cacheProperty = CacheProperty
                        .newLocalCacheProperty(AUTH_CACHE_NAME);
                this.authResourceMap = (ICache<Party, List<AuthResource>>) CacheFactory
                        .getInstance().createCache(cacheProperty);
//            } else {
//                CacheProperty cacheProperty = CacheProperty
//                        .newClusteredCacheProperty(AUTH_CACHE_NAME, null);
//
//                cacheProperty.setOtherProperties("CacheMode", "REPL_SYNC");
//                this.authResourceMap = (ICache<Party, List<AuthResource>>) CacheFactory
//                        .getInstance().createCache(cacheProperty);
//            }
        }
    }

    public void addAuthResourceList(Party roleParty,
                                    List<AuthResource> authResourceList) {
        this.authResourceMap.put(roleParty, authResourceList);
    }

    public void addOrUpdateAuthResource(Party roleParty,
                                        AuthResource authResource) {
        List<AuthResource> list = (List) this.authResourceMap.get(roleParty);
        if (list == null) {
            list = new ArrayList();
        }
        int index = list.indexOf(authResource);
        if (index == -1) {
            list.add(authResource);
        } else {
            ((AuthResource) list.get(index)).setState(authResource.getState());
        }
        this.authResourceMap.put(roleParty, list);
    }

    public void deleteAuthResourceList(Party roleParty) {
        this.authResourceMap.remove(roleParty);
    }

    public void deleteAuthResource(Party roleParty, AuthResource authResource) {
        List<AuthResource> list = (List) this.authResourceMap.get(roleParty);
        if (list != null) {
            list.remove(authResource);
            this.authResourceMap.put(roleParty, list);
        }
    }

    public List<AuthResource> getAuthResourceList(Party roleParty) {
        return (List) this.authResourceMap.get(roleParty);
    }

    public String getAuthResourceState(Party roleParty, String resourceID,
                                       String resourceType) {
        List<AuthResource> list = (List) this.authResourceMap.get(roleParty);
        int index = list.indexOf(new AuthResource(resourceID, resourceType));
        if (index == -1) {
            return null;
        }
        return ((AuthResource) list.get(index)).getState();
    }
}
