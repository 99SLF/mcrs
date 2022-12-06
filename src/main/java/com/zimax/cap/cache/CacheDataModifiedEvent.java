package com.zimax.cap.cache;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @author 苏尚文
 * @date 2022/12/5 18:05
 */
public class CacheDataModifiedEvent<K, V> {

    public static enum ModificationType {
        PUT_DATA, REMOVE_DATA, PUT_MAP;

        private ModificationType() {
        }
    }

    private Map<K, V> cacheData = new LinkedHashMap();
    private ModificationType modifyType;

    public Map<K, V> getCacheData() {
        return this.cacheData;
    }

    public void setCacheData(Map<K, V> cacheData) {
        this.cacheData.putAll(cacheData);
    }

    public void put(K key, V value) {
        this.cacheData.put(key, value);
    }

    public ModificationType getModificationType() {
        return this.modifyType;
    }

    public void setModificationType(ModificationType status) {
        this.modifyType = status;
    }
}
