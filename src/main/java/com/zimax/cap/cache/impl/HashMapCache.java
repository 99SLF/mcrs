package com.zimax.cap.cache.impl;

import com.zimax.cap.cache.AbstractCache;
import com.zimax.cap.cache.CacheHelper;
import com.zimax.cap.cache.CacheProperty;
import org.apache.log4j.Logger;

import java.lang.reflect.Method;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author 苏尚文
 * @date 2022/12/5 17:49
 */
public class HashMapCache<K, V> extends AbstractCache<K, V> {

    private static Logger serverlog = Logger.getLogger(HashMapCache.class);

    private static final long serialVersionUID = -2965520786669869959L;

    private ConcurrentHashMap<K, V> _cache = null;

    protected boolean isStarted = false;

    public HashMapCache(CacheProperty ap_Properties) {
        this._cache = new ConcurrentHashMap();
        this.targetName = (CacheHelper.getCurrentAppName() + ":" + ap_Properties
                .getCacheName());

//        super.init(ap_Properties);
    }

    public V getValue(Object key) {
        return getDirect(key);
    }

//    private boolean isInvalidation() {
//        String cacheMode = getCacheConfig().getOtherProperties().getProperty(
//                "CacheMode", "INVALIDATION_SYNC");
//        return cacheMode.toUpperCase().indexOf("INVALIDATION") != -1;
//    }

    public void putValue(K key, V value, boolean isSendMessage) {
        putDirect(key, value);
    }

    public void putMap(Map<K, V> dataMap, boolean isSendMessage) {
        putMapDirect(dataMap);
    }

    public V removeValue(Object key, boolean isSendMessage) {
        V ret = removeDirect(key);
        return ret;
    }

    public void removeAll(boolean isSendMessage) {
        removeAllDirect();
    }

    private static Method remotePutValueMethod = null;

    private static Method remotePutMapMethod = null;

    private static Method remoteRemoveValueMethod = null;

    private static Method remoteRemoveSetMethod = null;

    private static Method remoteRemoveAllMethod = null;

    private static Method remoteGetCacheMapMethod = null;

    private String targetName;

    static {
        try {
            remotePutValueMethod = HashMapCache.class.getDeclaredMethod(
                    "remotePutValue",
                    new Class[] { Object.class, Object.class });
            remotePutMapMethod = HashMapCache.class.getDeclaredMethod(
                    "remotePutMap", new Class[] { Map.class });
            remoteRemoveValueMethod = HashMapCache.class.getDeclaredMethod(
                    "remoteRemoveValue", new Class[] { Object.class });
            remoteRemoveSetMethod = HashMapCache.class.getDeclaredMethod(
                    "remoteRemoveSet", new Class[] { Set.class });
            remoteRemoveAllMethod = HashMapCache.class.getDeclaredMethod(
                    "remoteRemoveAll", new Class[0]);
            remoteGetCacheMapMethod = HashMapCache.class.getDeclaredMethod(
                    "getCacheMap", new Class[0]);
        } catch (Exception ignore) {
        }
    }

    public void remotePutValue(K key, V value) {
        putDirect(key, value);
        if (serverlog.isDebugEnabled()) {
//            serverlog.debug("<<<" + getCacheName() + ":  remotePutValue " + key
//                    + "-" + value);
        }
    }

    public void remotePutMap(Map<K, V> dataMap) {
        putMapDirect(dataMap);
    }

    public void remoteRemoveValue(Object key) {
        removeDirect(key);
        if (serverlog.isDebugEnabled()) {
//            serverlog.debug("<<<" + getCacheName() + ":  remoteRemoveValue "
//                    + key);
        }
    }

    public void remoteRemoveSet(Set<K> keySet) {
        if (keySet != null) {
            for (K key : keySet) {
                removeDirect(key);
            }
        }
    }

    public void remoteRemoveAll() {
        removeAllDirect();
    }

    public Map<K, V> getCacheMap() {
        return this._cache;
    }

    public Set<K> getAllKey() {
        return Collections.unmodifiableSet(this._cache.keySet());
    }

    public List<V> getAllValues() {
        Set<K> allKeys = this._cache.keySet();
        List<V> values = new ArrayList();
        for (K key : allKeys) {
            values.add(this._cache.get(key));
        }
        return Collections.unmodifiableList(values);
    }

    public int dataSize() {
        return this._cache.size();
    }

    protected void start() {
        if (!this.isStarted) {
            synchronized (this) {
                this.isStarted = true;
            }
        }
    }

    private void replCache() {

    }

    public void stop() {
        if (this.isStarted) {
            synchronized (this) {
                this.isStarted = false;
//                System.out.println("Application "
//                        + ApplicationContext.getInstance().getAppName()
//                        + "'s hashMapCache " + getCacheName() + " stopped.");
            }
        }
    }

    public String getCacheType() {
        return HashMap.class.getName();
    }

    public String getName() {
        return this.targetName;
    }

    public V getDirect(Object key) {
        return this._cache.get(key);
    }

    public void putDirect(K key, V value) {
        V oldValue = getDirect(key);
        this._cache.put(key, value);
//        if ((this.modifyListener != null) && (!value.equals(oldValue))) {
//            CacheDataModifiedEvent<K, V> modifyEnvent = new CacheDataModifiedEvent();
//            modifyEnvent
//                    .setModificationType(CacheDataModifiedEvent.ModificationType.PUT_DATA);
//            modifyEnvent.put(key, value);
//            this.modifyListener.onModification(modifyEnvent);
//        }
    }

    public void putMapDirect(Map<K, V> dataMap) {
        if ((dataMap != null) && (!dataMap.isEmpty())) {
            this._cache.putAll(dataMap);
//            if (this.modifyListener != null) {
//                CacheDataModifiedEvent<K, V> modifyEnvent = new CacheDataModifiedEvent();
//                modifyEnvent
//                        .setModificationType(CacheDataModifiedEvent.ModificationType.PUT_MAP);
//                modifyEnvent.setCacheData(dataMap);
//                this.modifyListener.onModification(modifyEnvent);
//            }
        }
    }

    public V removeDirect(Object key) {
        V ret = this._cache.remove(key);
//        if ((this.modifyListener != null) && (ret != null)) {
//            CacheDataModifiedEvent<K, V> modifyEnvent = new CacheDataModifiedEvent();
//            modifyEnvent
//                    .setModificationType(CacheDataModifiedEvent.ModificationType.REMOVE_DATA);
//            modifyEnvent.put((K) key, ret);
//            this.modifyListener.onModification(modifyEnvent);
//        }
        return ret;
    }

    public void removeAllDirect() {
//        CacheDataModifiedEvent<K, V> modifyEnvent = null;
//        if (this.modifyListener != null) {
//            modifyEnvent = new CacheDataModifiedEvent();
//            modifyEnvent
//                    .setModificationType(CacheDataModifiedEvent.ModificationType.REMOVE_DATA);
//            modifyEnvent.setCacheData(this._cache);
//        }
        this._cache.clear();
//        if ((this.modifyListener != null)
//                && (!modifyEnvent.getCacheData().isEmpty())) {
//            this.modifyListener.onModification(modifyEnvent);
//        }
    }
}
