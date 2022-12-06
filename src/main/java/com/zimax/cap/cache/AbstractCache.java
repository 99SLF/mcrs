package com.zimax.cap.cache;

import java.util.*;
import java.util.concurrent.locks.ReentrantReadWriteLock;

/**
 * @author 苏尚文
 * @date 2022/12/5 17:59
 */
public abstract class AbstractCache<K, V> implements ICache<K, V> {

    private String _cacheName = null;

    private CacheProperty _cacheConfig = null;

    private ICacheLoader<K, V> _cacheLoader;

    private boolean _dispatcheToLoaderFlag = false;

    private boolean _preloadFlag = false;

    protected CacheDataModificationListener<K, V> modifyListener;

    private ReentrantReadWriteLock lock = new ReentrantReadWriteLock(false);

    private ReentrantReadWriteLock.WriteLock writeLock = this.lock.writeLock();

    private ReentrantReadWriteLock.ReadLock readLock = this.lock.readLock();

    public void setDispatcheToLoader(boolean isDispatcheToLoader) {
        this._dispatcheToLoaderFlag = isDispatcheToLoader;
    }

    public boolean isDispatcheToLoader() {
        return this._dispatcheToLoaderFlag;
    }

    protected void init(CacheProperty ap_Properties) {
        this.writeLock.lock();
        try {
            this._cacheConfig = ap_Properties;
            this._cacheName = this._cacheConfig.getCacheName();
            this._cacheLoader = (ICacheLoader<K, V>) CacheHelper
                    .getCacheLoader(this._cacheConfig);
            this.modifyListener = CacheHelper
                    .getCacheModifyListener(this._cacheConfig);
            if ((this._cacheLoader != null)
                    && (IDispatchCacheLoader.class
                    .isAssignableFrom(this._cacheLoader.getClass()))) {
                ((IDispatchCacheLoader) this._cacheLoader).setCache(this);
                this._dispatcheToLoaderFlag = true;
            }
            start();
            if (this._preloadFlag) {
                return;
            }
            doPreLoad();
        } finally {
            this.writeLock.unlock();
        }
    }

    public void doPreLoad() {
        if (getCacheLoader() != null) {
            Map<K, V> dataMap = getCacheLoader().preLoad();
            if (dataMap != null) {
                putMap(dataMap, false);
            }
        }
        this._preloadFlag = true;
    }

    public String getCacheName() {
        return this._cacheName;
    }

    public int size() {
        this.readLock.lock();
        try {
            return dataSize();
        } finally {
            this.readLock.unlock();
        }
    }

    public boolean isEmpty() {
        return size() == 0;
    }

    public boolean containsKey(Object key) {
        return get(key) != null;
    }

    public boolean containsValue(Object value) {
        if (value == null) {
            return false;
        }
        Set<K> lst_AllKeys = keySet();
        if (lst_AllKeys == null) {
            return false;
        }
        for (Object key : lst_AllKeys) {
            if (value.equals(get(key))) {
                return true;
            }
        }
        return false;
    }

    public V get(Object key) {
        if (key == null) {
            return null;
        }
        this.writeLock.lock();
        try {
            if ((this._dispatcheToLoaderFlag) && (getCacheLoader() != null)) {
                return getCacheLoader().get(key);
            }
            Object value = getValue(key);
            if ((value == null) && (getCacheLoader() != null)) {
                value = getCacheLoader().get(key);
                if (value != null) {
                    putValue((K) key, (V) value, false);
                }
            }
            return (V) value;
        } finally {
            this.writeLock.unlock();
        }
    }

    public void put(K key, V value) {
        if ((key == null) || (value == null)) {
            return;
        }
        this.writeLock.lock();
        try {
            if ((this._dispatcheToLoaderFlag) && (getCacheLoader() != null)) {
                getCacheLoader().put(key, value);
            } else {
                if (getCacheLoader() != null) {
                    getCacheLoader().put(key, value);
                }
                putValue(key, value, true);
            }
        } finally {
            this.writeLock.unlock();
        }
    }

    public void putAll(Map<K, V> t) {
        this.writeLock.lock();
        try {
            if ((this._dispatcheToLoaderFlag) && (getCacheLoader() != null)
                    && ((getCacheLoader() instanceof IDispatchCacheLoader))) {
                ((IDispatchCacheLoader) getCacheLoader()).putAll(t);
            } else if ((t != null) && (!t.isEmpty())) {
                putMap(t, true);
            }
        } finally {
            this.writeLock.unlock();
        }
    }

    public V remove(Object key) {
        this.writeLock.lock();
        try {
            Object localObject1;
            if ((this._dispatcheToLoaderFlag) && (getCacheLoader() != null)) {
                return getCacheLoader().remove(key);
            }
            if (getCacheLoader() != null) {
                getCacheLoader().remove(key);
            }
            return removeValue(key, true);
        } finally {
            this.writeLock.unlock();
        }
    }

    public void clear() {
        this.writeLock.lock();
        try {
            removeAll(true);
        } finally {
            this.writeLock.unlock();
        }
    }

    public Set<K> keySet() {
        this.readLock.lock();
        try {
            if ((this._dispatcheToLoaderFlag) && (getCacheLoader() != null)
                    && ((getCacheLoader() instanceof IDispatchCacheLoader))) {
                return ((IDispatchCacheLoader) getCacheLoader()).keySet();
            }
            Set keys = new HashSet();
            keys.addAll(getAllKey());
            return keys;
        } finally {
            this.readLock.unlock();
        }
    }

    public CacheProperty getCacheConfig() {
        if (this._cacheConfig == null) {
            this._cacheConfig = CacheProperty
                    .newLocalCacheProperty(this._cacheName);
        }
        return this._cacheConfig.clone();
    }

    public ICacheLoader<K, V> getCacheLoader() {
        return this._cacheLoader;
    }

    public String toString() {
        this.readLock.lock();
        try {
            StringBuffer buf = new StringBuffer();
            buf.append(getClass().getName());
            buf.append(":");
            buf.append(this._cacheName);
            buf.append("{");
            Iterator<K> i = keySet().iterator();
            boolean hasNext = i.hasNext();
            K key;
            while (hasNext) {
                key = i.next();
                V value = getValue(key);
                if (key == this) {
                    buf.append("(this Cache)");
                } else {
                    buf.append(key);
                }
                buf.append("=");
                if (value == this) {
                    buf.append("(this Cache)");
                } else {
                    buf.append(value);
                }
                hasNext = i.hasNext();
                if (hasNext) {
                    buf.append(", ");
                }
            }
            buf.append("}");
            return buf.toString();
        } finally {
            this.readLock.unlock();
        }
    }

    public abstract V getValue(Object paramObject);

    public abstract void putValue(K paramK, V paramV, boolean paramBoolean);

    public abstract void putMap(Map<K, V> paramMap, boolean paramBoolean);

    public abstract V removeValue(Object paramObject, boolean paramBoolean);

    public abstract void removeAll(boolean paramBoolean);

    public abstract Set<K> getAllKey();

    public abstract List<V> getAllValues();

    public abstract int dataSize();

    protected abstract void start();

    public abstract void stop();
}
