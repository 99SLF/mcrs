package com.zimax.cap.cache;

import com.zimax.cap.cache.impl.HashMapCacheProvider;
import com.zimax.cap.utility.StringUtil;
import org.apache.log4j.Logger;

/**
 * 缓存帮助类
 *
 * @author 苏尚文
 * @date 2022/12/3 11:14
 */
public class CacheHelper {

    private static Logger log = Logger.getLogger(CacheHelper.class);

    public static final String EMBEDDED_CAHCE_NAME = "EMBEDDED_MANAGE_SERVER_CACHE";

    public static final String LOCAL = "LOCAL";

    public static final String INVALIDATION_SYNC = "INVALIDATION_SYNC";

    public static final String REPL_SYNC = "REPL_SYNC";

    public static final String INVALIDATION_ASYNC = "INVALIDATION_ASYNC";

    public static final String REPL_ASYNC = "REPL_ASYNC";

    static {
        Class providerClass = null;
        ICacheProvider provider = null;
        try {
            providerClass = Class
                    .forName("com.zimes.ext.common.cache.jboss.JBossCacheProvider");
            provider = (ICacheProvider) providerClass.newInstance();
            CacheProviderManager.registerProvider(provider.getType(), provider);
        } catch (Exception e) {
        }
        try {
            provider = new HashMapCacheProvider();
            CacheProviderManager.registerProvider(provider.getType(), provider);
        } catch (Exception e) {
            log.error(e);
        }
    }

    public static String getCurrentAppName() {
//        String appName = ApplicationContext.getInstance().getAppName();
        String appName = null;
        return appName == null ? "defaultApp" : appName;
    }

    public static String getIsolationLevel(CacheProperty cacheConfig) {
        String ls_IsolationLevel = cacheConfig.getIsolationLevel();
        if (StringUtil.isNullOrBlank(ls_IsolationLevel)) {
            ls_IsolationLevel = cacheConfig.getOtherProperties().getProperty(
                    "IsolationLevel");
        }
        return ls_IsolationLevel;
    }

//    public static boolean isClustered(CacheProperty cacheProperty) {
//        try {
//            Boolean isClustered = cacheProperty == null ? null : cacheProperty
//                    .getClustered();
//            CacheProperty.CacheClusterProperty clusterProp = cacheProperty
//                    .getClusterProperty();
//            String ls_ClusterName = clusterProp == null ? null : clusterProp
//                    .getClusterName();
//            if (isClustered == null) {
//                if (StringUtil.isNullOrBlank(ls_ClusterName)) {
//                    return DomainManager.getInstance().getCurrentServer()
//                            .getGroupName() != null;
//                }
//                return true;
//            }
//            return isClustered.booleanValue();
//        } catch (Throwable e) {
//            log.warn(
//                    "[cacheName={0}] isCurrentAppInClustered error.",
//                    new String[] { cacheProperty == null ? null : cacheProperty
//                            .getCacheName() }, e);
//        }
//        return false;
//    }

//    public static String getCacheMode(CacheProperty cacheConfig) {
//        String ls_CacheMode = cacheConfig.getOtherProperties().getProperty(
//                "CacheMode");
//        if (StringUtil.isNotNullAndBlank(ls_CacheMode)) {
//            return ls_CacheMode;
//        }
//        if (isClustered(cacheConfig)) {
//            ls_CacheMode = "INVALIDATION_SYNC";
//        } else {
//            ls_CacheMode = "LOCAL";
//        }
//        return ls_CacheMode;
//    }

//    public static String getClusterName(CacheProperty cacheConfig) {
//        String cacheName = cacheConfig.getCacheName();
//
//        String ls_CacheMode = getCacheMode(cacheConfig);
//        if (!"LOCAL".equals(ls_CacheMode)) {
//            CacheProperty.CacheClusterProperty clusterProp = cacheConfig
//                    .getClusterProperty();
//            String ls_ClusterName = clusterProp == null ? null : clusterProp
//                    .getClusterName();
//            if ((StringUtil.isNullOrBlank(ls_ClusterName))
//                    || ("NULL".equals(ls_ClusterName))) {
//                ls_ClusterName = cacheConfig.getOtherProperties().getProperty(
//                        "clusterName");
//                if ((StringUtil.isNullOrBlank(ls_ClusterName))
//                        || ("NULL".equals(ls_ClusterName))) {
//                    ls_ClusterName = cacheConfig.getOtherProperties()
//                            .getProperty("ClusterName");
//                }
//                if ((StringUtil.isNullOrBlank(ls_ClusterName))
//                        || ("NULL".equals(ls_ClusterName))) {
//                    String groupName = DomainManager.getInstance()
//                            .getCurrentServer().getGroupName();
//                    if (!StringUtil.isNullOrBlank(groupName)) {
//                        ls_ClusterName = StringUtil.concat(new Object[] {
//                                groupName, ":", getCurrentAppName(), ":",
//                                cacheName });
//                    } else {
//                        ls_ClusterName = StringUtil.concat(new Object[] {
//                                ServerContext.getInstance().getServerName()
//                                        + ":" + getCurrentAppName(), ":",
//                                cacheName });
//                    }
//                }
//            }
//            return ls_ClusterName;
//        }
//        return null;
//    }

    public static ICache<?, ?> createCache(CacheProperty cacheProperty)
            throws CacheRuntimeException {
        ICacheProvider cacheProvider = getCacheProvider(cacheProperty);
//        if (isClustered(cacheProperty)) {
//            try {
//                clusterModeCheck();
//            } catch (Exception e) {
//                log.warn(e.getMessage());
//                cacheProperty.setClustered(Boolean.valueOf(false));
//            }
//        }
        return cacheProvider.buildCache(cacheProperty);
    }

    private static boolean isSupportTransaction(CacheProperty cacheProperty) {
        try {
            String ls_IsolationLevel = cacheProperty == null ? null
                    : cacheProperty.getIsolationLevel();
            if ((ls_IsolationLevel == null)
                    || ("NULL".equalsIgnoreCase(ls_IsolationLevel))
                    || ("NONE".equalsIgnoreCase(ls_IsolationLevel))) {
                return false;
            }
            return true;
        } catch (Exception e) {
//            log.warn(
//                    "[cacheName={0}] isSupportTransaction error.",
//                    new String[] { cacheProperty == null ? null : cacheProperty
//                            .getCacheName() }, e);
        }
        return false;
    }

    private static ICacheProvider getCacheProvider(CacheProperty cacheProperty)
            throws CacheRuntimeException {
        ICacheProvider iCacheProvider = null;
        String cacheProviderName = cacheProperty == null ? null : cacheProperty
                .getCacheProvider();
        try {
            if (cacheProviderName == null) {
                if (isSupportTransaction(cacheProperty)) {
                    iCacheProvider = CacheProviderManager
                            .getCacheProvider(true);
                    if (iCacheProvider == null) {
                        iCacheProvider = CacheProviderManager
                                .getDefaultCacheProvider();
                    }
                } else {
                    iCacheProvider = CacheProviderManager
                            .getDefaultCacheProvider();
                }
            } else {
                iCacheProvider = (ICacheProvider) Class.forName(
                        cacheProviderName).newInstance();
            }
        } catch (InstantiationException e) {
//            log.error(
//                    "[cacheName={0}, cacheProviderName={1}] get cacheProvider error.",
//                    new String[] { cacheProperty.getCacheName(),
//                            cacheProviderName }, e);

            throw new CacheRuntimeException(ExceptionConstant.CACHE_13100020);
        } catch (IllegalAccessException e) {
//            log.error(
//                    "[cacheName={0}, cacheProviderName={1}] get cacheProvider error.",
//                    new String[] { cacheProperty.getCacheName(),
//                            cacheProviderName }, e);

            throw new CacheRuntimeException(ExceptionConstant.CACHE_13100030);
        } catch (ClassNotFoundException e) {
//            log.error(
//                    "[cacheName={0}, cacheProviderName={1}] get cacheProvider error.",
//                    new String[] { cacheProperty.getCacheName(),
//                            cacheProviderName }, e);

            throw new CacheRuntimeException(ExceptionConstant.CACHE_13100040);
        }
        return iCacheProvider;
    }

    public static CacheDataModificationListener getCacheModifyListener(
            CacheProperty cacheProperty) {
        if (cacheProperty == null) {
            return null;
        }
        CacheDataModificationListener listener = null;
        String listenerClassName = cacheProperty == null ? null : cacheProperty
                .getOtherProperties().getProperty(
                        "CacheDataModificationListener");
//        if (StringUtil.isNotNullAndBlank(listenerClassName)) {
//            try {
//                listener = (CacheDataModificationListener) Class.forName(
//                        listenerClassName).newInstance();
//            } catch (Exception ignore) {
//                log.warn(
//                        "[cacheName={0}, listenerClassName={1}] get listenerClassName error.",
//                        new String[] { cacheProperty.getCacheName(),
//                                listenerClassName }, ignore);
//            }
//        }
        return listener;
    }

    public static ICacheLoader<?, ?> getCacheLoader(CacheProperty cacheProperty) {
        if (cacheProperty == null) {
            return null;
        }
        ICacheLoader<?, ?> cacheLoader = null;

        String loaderClassName = cacheProperty == null ? null : cacheProperty
                .getCacheLoader();
        if (loaderClassName == null) {
//            if ((cacheProperty instanceof BizLogicCacheProperty)) {
//                loaderClassName = "com.zimes.ext.engine.component.cache.BizLogicCacheLoader";
//            } else if ((cacheProperty instanceof DataEntityCacheProperty)) {
//                loaderClassName = "com.zimes.ext.das.entity.cache.DataEntityCacheLoader";
//            } else if ((cacheProperty instanceof NamingSqlCacheProperty)) {
//                loaderClassName = "com.zimes.ext.das.sql.cache.NamingSqlCacheLoader";
//            }
        }
        if (loaderClassName != null) {
            try {
                cacheLoader = (ICacheLoader) Class.forName(loaderClassName)
                        .newInstance();
            } catch (Exception ignore) {
//                log.warn(
//                        "[cacheName={0}, cacheLoaderName={1}] get cacheLoader error.",
//                        new String[] { cacheProperty.getCacheName(),
//                                loaderClassName }, ignore);
            }
        }
        return cacheLoader;
    }

//    public static String getChannelName() {
//        String channelName = EnvironmentConfigHelper
//                .getSystemConfigValue("ChannelName");
//        if (StringUtil.isNullOrBlank(channelName)) {
//            channelName = "EOSDomain_"
//                    + ServerContext.getInstance().getAdminServerIP() + ":"
//                    + ServerContext.getInstance().getAdminServerPort();
//        }
//        return channelName;
//    }

//    public static void clusterModeCheck() {
//        String clusteredMode = ImprimaturMgr
//                .getImprimaturPropertyValue("cluster");
//        if ("false".equals(clusteredMode)) {
//            throw new CacheRuntimeException("13100121");
//        }
//    }
}
