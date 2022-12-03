package com.zimax.cap.cache;

/**
 * @author 苏尚文
 * @date 2022/12/3 11:15
 */
public interface ICacheProvider {

    ICache<?, ?> buildCache(CacheProperty paramCacheProperty)
            throws CacheRuntimeException;

    String getType();

    boolean isTransactionSupported();

    int getPriority();
}
