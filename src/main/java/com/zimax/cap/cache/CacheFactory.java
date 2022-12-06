package com.zimax.cap.cache;

import com.zimax.cap.cache.impl.HashMapCacheProvider;
import org.apache.log4j.Logger;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.locks.ReentrantReadWriteLock;

/**
 * 缓存工厂
 *
 * @author 苏尚文
 * @date 2022/12/3 11:09
 */
public class CacheFactory {

    private static Logger log = Logger.getLogger(CacheFactory.class);

    private static CacheFactory instance = null;

    private Map<String, ICache<?, ?>> lm_Caches = null;

    private ReentrantReadWriteLock lock = new ReentrantReadWriteLock(false);

    private ReentrantReadWriteLock.WriteLock writeLock = this.lock.writeLock();

    private ReentrantReadWriteLock.ReadLock readLock = this.lock.readLock();

    public static synchronized CacheFactory getInstance() {
        if (instance == null) {
            try {
                instance = new CacheFactory();
            } catch (Exception e) {
                instance = null;
            }
        }
        return instance;
    }

    protected CacheFactory() throws Exception {
        this.lm_Caches = new HashMap<String, ICache<?, ?>>();
        CacheProperty cacheProperty = CacheProperty.newLocalCacheProperty("CacheForUserObject");
        cacheProperty.setSystemCache(true);
        cacheProperty.setCacheProvider(HashMapCacheProvider.class.getName());
        createCache(cacheProperty);
    }

    public ICache<?, ?> createCache(CacheProperty cacheConfig)
            throws CacheRuntimeException {
        return createCache(cacheConfig, false);
    }

    public ICache<?, ?> createCache(CacheProperty cacheConfig,
                                    boolean persistentFlag) throws CacheRuntimeException {
        this.writeLock.lock();
        try {
            return doCreateCache(cacheConfig, persistentFlag);
        } finally {
            this.writeLock.unlock();
        }
    }

    private ICache<?, ?> doCreateCache(CacheProperty cacheConfig,
                                       boolean persistentFlag) throws CacheRuntimeException {
        if (cacheConfig == null) {
            return null;
        }
        String cacheName = cacheConfig.getCacheName();
        if (this.lm_Caches.get(cacheName) != null) {
//            log.warn("[cache={0}] is already existed!",
//                    new String[]{cacheName});
            throw new CacheRuntimeException(ExceptionConstant.CACHE_13100050,
                    new String[]{cacheName});
        }
        ICache<?, ?> iCache = CacheHelper.createCache(cacheConfig);

        this.lm_Caches.put(cacheName, iCache);
        if (persistentFlag) {
//            CacheConfigParser.getInstance().updateAndSaveConfigFile(cacheName,
//                    cacheConfig);
        }
        return iCache;
    }

    public ICache<?, ?> findCache(String cacheName) {
        if (cacheName == null) {
            return null;
        }
        this.writeLock.lock();
        try {
            ICache<?, ?> iCache = this.lm_Caches.get(cacheName);
            CacheProperty cacheConfig;
            if (iCache == null) {
//                cacheConfig = CacheConfigParser.getInstance().getCacheProperty(
//                        cacheName);
//                if (cacheConfig != null) {
//                    iCache = doCreateCache(cacheConfig, false);
//                }
            }
            return iCache;
        } finally {
            this.writeLock.unlock();
        }
    }

//    public void destroyCache(String cacheName) {
//        destroyCache(cacheName, false);
//    }

//    public void destroyCache(String cacheName, boolean persistentFlag) {
//        this.writeLock.lock();
//        try {
//            doDestroyCache(cacheName, persistentFlag);
//        } finally {
//            this.writeLock.unlock();
//        }
//    }

//    private void doDestroyCache(String cacheName, boolean persistentFlag) {
//        if (cacheName == null) {
//            return;
//        }
//        ICache<?, ?> cache = this.lm_Caches.get(cacheName);
//        if (cache == null) {
//            return;
//        }
//        if (AbstractCache.class.isAssignableFrom(cache.getClass())) {
//            AbstractCache absCache = (AbstractCache) cache;
//            absCache.removeAll(false);
//            absCache.stop();
//        } else {
//            cache.clear();
//        }
//        cache = null;
//        this.lm_Caches.remove(cacheName);
//        if (persistentFlag) {
//            CacheConfigParser.getInstance().removeAndSaveConfigFile(cacheName);
//        }
//    }

//    public void destroyCache() {
//        this.writeLock.lock();
//        try {
//            if (instance == null) {
//                return;
//            }
//            instance = null;
//            if (this.lm_Caches == null) {
//                return;
//            }
//            for (String cacheName : (String[]) this.lm_Caches.keySet().toArray(
//                    new String[0])) {
//                doDestroyCache(cacheName, false);
//            }
//            ClusterServiceFactoryManager.destroyAll();
//
//            this.lm_Caches = null;
//        } finally {
//            this.writeLock.unlock();
//        }
//    }

//    public boolean exists(String cacheName) {
//        return findCache(cacheName) != null;
//    }

    public Set<String> keySet() {
        this.readLock.lock();
        try {
            return Collections.unmodifiableSet(this.lm_Caches.keySet());
        } finally {
            this.readLock.unlock();
        }
    }
}
