package com.zimax.cap.cache;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * 缓存提供者管理器
 *
 * @author 苏尚文
 * @date 2022/12/3 11:16
 */
public class CacheProviderManager {

    private static Map<String, ICacheProvider> cacheProviders = new HashMap();

    public static void registerProvider(String type, ICacheProvider provider) {
        cacheProviders.put(type, provider);
    }

    public static void unregisterProvider(String type) {
        cacheProviders.remove(type);
    }

    public static ICacheProvider getCacheProvider(String type) {
        ICacheProvider provider = (ICacheProvider) cacheProviders.get(type);
        if (provider == null) {
            provider = getDefaultCacheProvider();
        }
        return provider;
    }

    public static ICacheProvider getDefaultCacheProvider() {
        return (ICacheProvider) cacheProviders.get("HashMapCacheProvider");
    }

    public static ICacheProvider getCacheProvider(boolean transactionSupported) {
        int maxPriority = 0;
        ICacheProvider retProvider = null;
        for (Iterator<String> it = cacheProviders.keySet().iterator(); it.hasNext(); ) {
            String type = (String) it.next();
            ICacheProvider provider = (ICacheProvider) cacheProviders.get(type);
            if (provider.isTransactionSupported()) {
                if (retProvider == null) {
                    retProvider = provider;
                    maxPriority = provider.getPriority();
                } else if (provider.getPriority() > maxPriority) {
                    maxPriority = provider.getPriority();
                    retProvider = provider;
                }
            }
        }
        return retProvider;
    }

    public static void clear() {
        cacheProviders.clear();
    }
}
