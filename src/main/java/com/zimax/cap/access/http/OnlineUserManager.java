package com.zimax.cap.access.http;

import com.zimax.cap.cache.CacheFactory;
import com.zimax.cap.cache.ICache;
import com.zimax.cap.common.muo.MUODataContextHelper;
import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.datacontext.IRequestMap;
import com.zimax.cap.datacontext.ISessionMap;
import com.zimax.cap.exception.CapRuntimeException;
import com.zimax.cap.party.IUserObject;
import com.zimax.cap.party.impl.UserObject;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 在线用户管理器
 *
 * @author 苏尚文
 * @date 2022/12/3 10:56
 */
public class OnlineUserManager {

    private static final String CONSTANT_CACHE_USEROBJECT = "CacheForUserObject";

    private static Logger logger = Logger.getLogger(OnlineUserManager.class);

    private static Object FLAG = new Object();

    private static ICache<String, IUserObject> cache;

    private static Map<String, Map<String, Object>> userIdUniqueIdMap = new ConcurrentHashMap();

    private static long ScanningThreadSleepTime = 2000L;

    private static ScanningThread scanningThread = null;

    private static class ScanningThread extends Thread {
        private boolean stopped = false;

        public void exit() {
            this.stopped = true;
            interrupt();
        }

        public void run() {
            for (;;) {
                if (!this.stopped) {
                    try {
                        Map<String, Map<String, Object>> tmpMap = new ConcurrentHashMap<String, Map<String, Object>>();
                        if (OnlineUserManager.cache != null) {
                            Set<String> keySet = OnlineUserManager.cache
                                    .keySet();
                            for (String key : keySet) {
                                OnlineUserManager.addUserIdUniqueIdMapping(
                                        (IUserObject) OnlineUserManager.cache
                                                .get(key), tmpMap);
                            }
                            OnlineUserManager.userIdUniqueIdMap = tmpMap;
                        }
                        try {
                            Thread.sleep(OnlineUserManager.ScanningThreadSleepTime);
                        } catch (InterruptedException e) {
                            if ((OnlineUserManager.logger != null)
                                    && (OnlineUserManager.logger.isTraceEnabled())) {
                                OnlineUserManager.logger.warn(Thread
                                        .currentThread().getName()
                                        + " is interrupted.");
                            }
                            this.stopped = true;
                        }
                    } catch (Throwable e) {
                        if ((OnlineUserManager.logger != null)
                                && (OnlineUserManager.logger.isTraceEnabled())) {
                            OnlineUserManager.logger.warn(Thread
                                    .currentThread().getName()
                                    + " is interrupted.");
                        }
                    } finally {
                        try {
                            Thread.sleep(OnlineUserManager.ScanningThreadSleepTime);
                        } catch (InterruptedException e) {
                            if ((OnlineUserManager.logger != null)
                                    && (OnlineUserManager.logger
                                    .isTraceEnabled())) {
                                OnlineUserManager.logger.warn(Thread
                                        .currentThread().getName()
                                        + " is interrupted.");
                            }
                            this.stopped = true;
                        }
                    }
                }
            }
        }
    }

    static {
        CacheFactory cacheManagerFactory = CacheFactory.getInstance();
        cache = (ICache<String, IUserObject>) cacheManagerFactory
                .findCache("CacheForUserObject");
        if (cache == null) {
            logger.error("cache CacheForUserObject not created, please check cache config in user-config.xml.");
        }
        scanningThread = new ScanningThread();
        scanningThread.setDaemon(true);
        scanningThread.setName("UserObjectScanningThread");
        scanningThread.start();
    }

    public static void stop() {
        if (scanningThread != null) {
            scanningThread.exit();
            scanningThread = null;
        }
        cache = null;
        logger = null;
    }

    /**
     * 是否允许用户多次登录
     */
    private static boolean allowOneUserLoginManyTimes = true;

    /**
     * 用户登录
     *
     * @param userObject 用户对象
     */
    public static void login(IUserObject userObject) {
        login(userObject, allowOneUserLoginManyTimes);
    }

    /**
     * 用户登录
     *
     * @param userObject 用户对象
     * @param allowOneUserLoginManyTimes 是否允许用户多次登录
     */
    public static void login(IUserObject userObject, boolean allowOneUserLoginManyTimes) {
        if (userObject == null) {
            throw new CapRuntimeException("12101006");
        }
        setRemoteIP(userObject);
        try {
            ISessionMap sessionMap = DataContextManager.current()
                    .getSessionCtx();
            if (sessionMap == null) {
                sessionMap = MUODataContextHelper.getMapContextFactory()
                        .getSessionMap();
            }
            if (sessionMap != null) {
                Object rootObject = sessionMap.getRootObject();
                if ((rootObject != null)
                        && ((rootObject instanceof HttpSession))) {
                    HttpSession session = (HttpSession) rootObject;
                    if (UserObject.class
                            .isAssignableFrom(userObject.getClass())) {
                        ((UserObject) userObject).setSessionId(session.getId());
                        ((UserObject) userObject).setUniqueId(session.getId());
                    }
                    if (cache != null) {
                        if (!allowOneUserLoginManyTimes) {
                            kickOffByUserId(userObject.getUserId());
                        }
                        cache.put(userObject.getUniqueId(), userObject);
                        addUserIdUniqueIdMapping(userObject);
                    }
                    session.setAttribute("userObject", userObject);
                    return;
                }
            }
            if (cache != null) {
                if (!allowOneUserLoginManyTimes) {
                    kickOffByUserId(userObject.getUserId());
                }
                cache.put(userObject.getUniqueId(), userObject);
                addUserIdUniqueIdMapping(userObject);
            }
        } catch (Throwable t) {
            logger.error(t);
            throw new CapRuntimeException("12101007", t);
        }
    }

    private static void setRemoteIP(IUserObject userObject) {
        if ((userObject instanceof UserObject)) {
            String ip = ((UserObject) userObject).getUserRemoteIp();
            if ((ip == null) || (ip.trim().equals(""))) {
                IRequestMap requestMap = DataContextManager.current()
                        .getRequestCtx();
                if (requestMap == null) {
                    requestMap = MUODataContextHelper.getMapContextFactory()
                            .getRequestMap();
                }
                if (requestMap == null) {
                    logger.warn("cannot get request from DataContextManager and MUODataContextHelper!");
                    return;
                }
                Object reqObject = requestMap.getRootObject();
                if ((reqObject instanceof HttpServletRequest)) {
                    HttpServletRequest request = (HttpServletRequest) reqObject;
                    ((UserObject) userObject).setUserRemoteIp(HttpHelper
                            .getRemoteAddr(request));
                } else {
                    logger.warn("cannot set UserRemoteIP,because cannot get HttpServletRequest!");
                }
            }
        }
    }

    static IUserObject logoutByUniqueId(String uniqueId, boolean isRemoveSession) {
        if (uniqueId == null) {
            return null;
        }
        IUserObject removedUser = (IUserObject) cache.remove(uniqueId);
        removeUserIdUniqueIdMapping(removedUser);
        if (isRemoveSession) {
            removeUserObjectFromSession(uniqueId);
        }
        return removedUser;
    }

    public static IUserObject logoutByUniqueId(String uniqueId) {
        return logoutByUniqueId(uniqueId, true);
    }

    public static IUserObject getUserObjectsByUniqueId(String uniqueId) {
        return (IUserObject) cache.get(uniqueId);
    }

    public static IUserObject[] getUserObjects() {
        List<IUserObject> users = new ArrayList();
        for (Iterator it = cache.keySet().iterator(); it.hasNext();) {
            users.add(cache.get(it.next()));
        }
        IUserObject[] ret = new IUserObject[users.size()];
        users.toArray(ret);
        return ret;
    }

    public static IUserObject[] kickOffByUserId(String userId) {
        if (userId == null) {
            return new IUserObject[0];
        }
        Map<String, Object> uniqueIds = new ConcurrentHashMap();
        Map<String, Object> uuids = (Map) userIdUniqueIdMap.get(userId);
        if (uuids == null) {
            return new IUserObject[0];
        }
        uniqueIds.putAll(uuids);
        List<IUserObject> users = new ArrayList();
        for (String key : uniqueIds.keySet()) {
            IUserObject userObject = (IUserObject) cache.remove(key);
            removeUserIdUniqueIdMapping(userObject);
            users.add(userObject);
            removeUserObjectFromSession(key);
        }
        return (IUserObject[]) users.toArray(new IUserObject[users.size()]);
    }

    public static void resetSessionBinding(IUserObject user, String sessionId) {
        String uniqueId = user.getUniqueId();

        UserObject userOnline = (UserObject) cache.get(uniqueId);
        if (userOnline == null) {
            return;
        }
        userOnline.setSessionId(sessionId);

        Map<String, Object> uuids = (Map) userIdUniqueIdMap.get(user
                .getUserId());
        if (uuids == null) {
            return;
        }
        Map<String, Object> newUuids = new ConcurrentHashMap(uuids);
        for (String uuid : newUuids.keySet()) {
            IUserObject oldUO = (IUserObject) cache.get(uuid);
            if (oldUO != null) {
                if (!oldUO.getUniqueId().equals(uniqueId)) {
                    if ((oldUO.getSessionId() != null)
                            && (oldUO.getSessionId().equals(sessionId))) {
                        IUserObject userObject = (IUserObject) cache
                                .remove(uuid);
                        removeUserIdUniqueIdMapping(userObject);
                    }
                }
            }
        }
    }

    public static void delSessionBinding(IUserObject old) {
        String uniqueId = old.getUniqueId();
        if (cache.containsKey(uniqueId)) {
            IUserObject userObject = (IUserObject) cache.remove(uniqueId);
            removeUserIdUniqueIdMapping(userObject);
        }
    }

    public static void addSessionBinding(IUserObject newUser) {
        String uniqueId = newUser.getUniqueId();
        if (!cache.containsKey(uniqueId)) {
            cache.put(uniqueId, newUser);
            addUserIdUniqueIdMapping(newUser);
        }
    }

    public static IUserObject[] getUserObjectsByUserId(String userId) {
        if (userId == null) {
            return new IUserObject[0];
        }
        Map<String, Object> uniqueIds = (Map) userIdUniqueIdMap.get(userId);
        if ((uniqueIds == null) || (uniqueIds.size() == 0)) {
            return new IUserObject[0];
        }
        IUserObject[] arr = new IUserObject[uniqueIds.size()];
        int i = 0;
        for (String uniqueId : uniqueIds.keySet()) {
            arr[i] = getUserObjectsByUniqueId(uniqueId);
            i++;
        }
        return arr;
    }

    private static HttpSession getCurrentSession() {
        ISessionMap sessionMap = DataContextManager.current().getSessionCtx();
        if (sessionMap == null) {
            sessionMap = MUODataContextHelper.getMapContextFactory()
                    .getSessionMap();
        }
        if (sessionMap != null) {
            Object rootObject = sessionMap.getRootObject();
            if ((rootObject instanceof HttpSession)) {
                return (HttpSession) rootObject;
            }
        }
        return null;
    }

    private static void removeUserObjectFromSession(String uniqueId) {
        if (uniqueId == null) {
            return;
        }
        HttpSession session = getCurrentSession();
        if (session != null) {
            IUserObject userObject = (IUserObject) session
                    .getAttribute("userObject");
            if ((userObject != null)
                    && (uniqueId.equals(userObject.getUniqueId()))) {
                session.removeAttribute("userObject");
            }
        }
    }

    public static void addUserIdUniqueIdMapping(IUserObject userObject) {
        addUserIdUniqueIdMapping(userObject, userIdUniqueIdMap);
    }

    private static void addUserIdUniqueIdMapping(IUserObject userObject,
                                                 Map<String, Map<String, Object>> userIdUniqueIdMap) {
        if (userObject == null) {
            return;
        }
        if (userObject.getUserId() == null) {
            return;
        }
        Map<String, Object> mapping = (Map) userIdUniqueIdMap.get(userObject
                .getUserId());
        if (mapping == null) {
            mapping = new ConcurrentHashMap();
            userIdUniqueIdMap.put(userObject.getUserId(), mapping);
        }
        if (userObject.getUniqueId() != null) {
            mapping.put(userObject.getUniqueId(), FLAG);
        }
    }

    public static void removeUserIdUniqueIdMapping(IUserObject userObject) {
        if (userObject == null) {
            return;
        }
        if (userObject.getUserId() == null) {
            return;
        }
        Map<String, Object> mapping = (Map) userIdUniqueIdMap.get(userObject
                .getUserId());
        if (mapping == null) {
            return;
        }
        if (userObject.getUniqueId() == null) {
            return;
        }
        mapping.remove(userObject.getUniqueId());
    }

    public static void removeLocalOldUserObject(IUserObject user) {
    }
}
