package com.zimax.cap.cache;

import java.util.Map;

/**
 * 缓存加载器
 *
 * @author 苏尚文
 * @date 2022/12/3 11:05
 */
public interface ICacheLoader<K, V> {

    Map<K, V> preLoad();

    V get(Object paramObject);

    void put(K paramK, V paramV);

    V remove(Object paramObject);
}
