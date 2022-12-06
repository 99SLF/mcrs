package com.zimax.cap.cache;

import java.util.Map;
import java.util.Set;

/**
 * @author 苏尚文
 * @date 2022/12/5 18:08
 */
public interface IDispatchCacheLoader<K, V>
        extends ICacheLoader<K, V> {

    void setCache(ICache<K, V> paramICache);

    Set<K> keySet();

    void putAll(Map<K, V> paramMap);
}
