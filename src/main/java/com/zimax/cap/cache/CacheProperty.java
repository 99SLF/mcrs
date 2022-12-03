package com.zimax.cap.cache;

import com.zimax.cap.utility.StringUtil;

import java.io.Serializable;
import java.util.Map;
import java.util.Properties;

/**
 * 缓存属性
 *
 * @author 苏尚文
 * @date 2022/12/3 11:01
 */
public class CacheProperty implements Serializable, Cloneable {

    private static final long serialVersionUID = -6092910140342731606L;

    public static final String NONE = "none";

    public static final String SERIALIZABLE = "serializable";

    public static final String REPEATABLE_READ = "repeatable_read";

    public static final String READ_COMMITTED = "read_committed";

    public static final String READ_UNCOMMITTED = "read_uncommitted";

    private String cacheName;

    private String cacheProvider;

    private String cacheLoader;

    private Boolean clustered;

    private CacheClusterProperty clusterProperty;

    private String isolationLevel = "none";

    private Boolean isSystemCache = Boolean.FALSE;

    private Properties cacheOtherProp = new Properties();

    public CacheProperty() {
    }

    @Deprecated
    public CacheProperty(String cacheName) {
        this.cacheName = cacheName;
    }

    public static CacheProperty newLocalCacheProperty(String cacheName) {
        CacheProperty config = new CacheProperty(cacheName);
        config.setClustered(Boolean.valueOf(false));

        return config;
    }

    public static CacheProperty newClusteredCacheProperty(String cacheName, String clusterName) {
        CacheProperty config = new CacheProperty(cacheName);
        config.setClustered(Boolean.valueOf(true));
        if (!StringUtil.isNullOrBlank(clusterName)) {
            CacheClusterProperty clusterconfig = new CacheClusterProperty();
            clusterconfig.setClusterName(clusterName);
            config.setClusterProperty(clusterconfig);
        }
        return config;
    }

    public String getCacheName() {
        return this.cacheName;
    }

    public void setCacheName(String cacheName) {
        this.cacheName = cacheName;
    }

    public String getCacheProvider() {
        return this.cacheProvider;
    }

    public void setCacheProvider(String cacheProvider) {
        this.cacheProvider = cacheProvider;
    }

    public String getCacheLoader() {
        return this.cacheLoader;
    }

    public void setCacheLoader(String cacheLoader) {
        this.cacheLoader = cacheLoader;
    }

    public Boolean getClustered() {
        return this.clustered;
    }

    public void setClustered(Boolean clustered) {
        this.clustered = clustered;
    }

    public CacheClusterProperty getClusterProperty() {
        return this.clusterProperty;
    }

    public void setClusterProperty(CacheClusterProperty clusterProperty) {
        this.clusterProperty = clusterProperty;
    }

    /**
     * @deprecated
     */
    public String getIsolationLevel() {
        return this.isolationLevel;
    }

    /**
     * @deprecated
     */
    public void setIsolationLevel(String isolationLevel) {
        this.isolationLevel = isolationLevel;
    }

    public Boolean getSystemCache() {
        return this.isSystemCache;
    }

    public void setSystemCache(Boolean systemCacheFlag) {
        this.isSystemCache = systemCacheFlag;
    }

    public Properties getOtherProperties() {
        return this.cacheOtherProp;
    }

    public void setOtherProperties(Properties cacheProp) {
        this.cacheOtherProp.putAll(cacheProp);
    }

    public void setOtherProperties(String key, String value) {
        this.cacheOtherProp.setProperty(key, value);
    }

    public CacheProperty clone() {
        CacheProperty result = null;
        try {
            result = (CacheProperty) super.clone();
            if (this.cacheOtherProp != null) {
                result.cacheOtherProp = new Properties();
                for (Map.Entry<Object, Object> entry : this.cacheOtherProp.entrySet()) {
                    result.cacheOtherProp.put(entry.getKey(), entry.getValue());
                }
            }
        } catch (CloneNotSupportedException e) {
        }
        return result;
    }

    public static class CacheClusterProperty
            implements Serializable, Cloneable {

        private static final long serialVersionUID = 5044389621431258526L;

        private String clusterName;

        private String mcastAddr;

        private int mcastPort;

        private String bindAddr;

        private int bindPort;

        @Deprecated
        public static final int NOTIFY_TYPE_JGROUPS = 1;

        public static final int NOTIFY_TYPE_MBEAN = 2;

        private int notifyType = 2;

        public String getClusterName() {
            return this.clusterName;
        }

        public void setClusterName(String clusterName) {
            this.clusterName = clusterName;
        }

        public String getMcastAddr() {
            return this.mcastAddr;
        }

        public void setMcastAddr(String mcastAddr) {
            this.mcastAddr = mcastAddr;
        }

        public int getMcastPort() {
            return this.mcastPort;
        }

        public void setMcastPort(int mcastPort) {
            this.mcastPort = mcastPort;
        }

        public String getBindAddr() {
            return this.bindAddr;
        }

        public void setBindAddr(String bindAddr) {
            this.bindAddr = bindAddr;
        }

        public int getBindPort() {
            return this.bindPort;
        }

        public void setBindPort(int bindPort) {
            this.bindPort = bindPort;
        }

        public int getNotifyType() {
            return this.notifyType;
        }

        public void setNotifyType(int notifyType) {
            this.notifyType = notifyType;
        }

        public CacheProperty clone() {
            CacheProperty result = null;
            try {
                result = (CacheProperty) super.clone();
            } catch (CloneNotSupportedException e) {
            }
            return result;
        }
    }
}
