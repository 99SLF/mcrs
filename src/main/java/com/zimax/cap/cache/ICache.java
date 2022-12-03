package com.zimax.cap.cache;

import java.io.Serializable;
import java.util.Map;
import java.util.Set;

/**
 * 缓存接口
 *
 * @author 苏尚文
 * @date 2022/12/3 10:59
 * @param <K>
 * @param <V>
 */
public interface ICache<K, V> extends Serializable {

    public String getCacheName();

    public int size();

    public boolean isEmpty();

    public boolean containsKey(Object paramObject);

    public boolean containsValue(Object paramObject);

    public V get(Object paramObject);

    public void put(K paramK, V paramV);

    public void putAll(Map<K, V> paramMap);

    public V remove(Object paramObject);

    public void clear();

    public Set<K> keySet();

    public String getCacheType();

    public CacheProperty getCacheConfig();

    public ICacheLoader<K, V> getCacheLoader();
}
