package com.zimax.cap.cache;

/**
 * @author 苏尚文
 * @date 2022/12/5 18:04
 */
public interface CacheDataModificationListener<K, V> {

    void onModification(CacheDataModifiedEvent<K, V> event);

}
