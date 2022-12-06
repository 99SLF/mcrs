package com.zimax.cap.cache.impl;

import com.zimax.cap.cache.CacheHelper;
import com.zimax.cap.cache.CacheProperty;
import com.zimax.cap.cache.ICache;
import com.zimax.cap.cache.ICacheProvider;

/**
 * @author 苏尚文
 * @date 2022/12/5 17:46
 */
public class HashMapCacheProvider implements ICacheProvider {

    public static final String HASHMAP_CACHE_PROVIDER_TYPE = "HashMapCacheProvider";

    public String getType() {
        return "HashMapCacheProvider";
    }

    public ICache<?, ?> buildCache(CacheProperty cacheConfig) {
        return new HashMapCache(cacheConfig);
    }

    public boolean isTransactionSupported() {
        return false;
    }

    public int getPriority() {
        return 100;
    }

}
