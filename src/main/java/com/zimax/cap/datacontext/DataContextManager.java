package com.zimax.cap.datacontext;

import java.util.*;

/**
 * 数据环境管理器
 *
 * @author 苏尚文
 * @date 2022/12/3 11:49
 */
public class DataContextManager extends HashMap {

    private static final long serialVersionUID = 1L;

    protected static ThreadLocal currentBus = new ThreadLocal();

    private DataContextService service;

    public int size() {
        return this.service.size();
    }

    public boolean isEmpty() {
        return this.service.isEmpty();
    }

    public Object get(Object key) {
        return this.service.get(key);
    }

    public boolean containsKey(Object key) {
        return this.service.containsKey(key);
    }

    public Object put(Object key, Object value) {
        return this.service.put(key, value);
    }

    public boolean equals(Object o) {
        return this.service.equals(o);
    }

    public void putAll(Map m) {
        this.service.putAll(m);
    }

    public int hashCode() {
        return this.service.hashCode();
    }

    public String toString() {
        return this.service.toString();
    }

    public Object remove(Object key) {
        return this.service.remove(key);
    }

    public void clear() {
        this.service.clear();
    }

    public boolean containsValue(Object value) {
        return this.service.containsValue(value);
    }

    public Object clone() {
        return this.service.clone();
    }

    public Set keySet() {
        return this.service.keySet();
    }

    public Collection values() {
        return this.service.values();
    }

    public Set entrySet() {
        return this.service.entrySet();
    }

//    protected Stack<ContributionMetaData> contributionMetaDataStack = new Stack();

//    public void setCurrentLocale(Locale currentLocale) {
//        this.service.setCurrentLocale(currentLocale);
//    }

    public Locale getCurrentLocale() {
        return this.service.getCurrentLocale();
    }

//    public ContextStack getContextStack() {
//        return this.service.getContextStack();
//    }

//    public IDataContext getDefaultContext() {
//        return this.service.getDefaultContext();
//    }

//    public IApplicationMap getApplicationCtx() {
//        return this.service.getApplicationCtx();
//    }

//    public IParameterMap getParameterCtx() {
//        return this.service.getParameterCtx();
//    }

    public IRequestMap getRequestCtx() {
        return this.service.getRequestCtx();
    }

    public ISessionMap getSessionCtx() {
        return this.service.getSessionCtx();
    }

//    public IPageMap getPageCtx(PageContext pageContext) {
//        return this.service.getPageCtx(pageContext);
//    }

//    public IMapContextFactory getMapContextFactory() {
//        return this.service.getMapContextFactory();
//    }

//    public void setMapContextFactory(IMapContextFactory mapContextFactory) {
//        this.service.setMapContextFactory(mapContextFactory);
//    }

    public IMUODataContext getMUODataContext() {
        return this.service.getMUODataContext();
    }

//    public IMUODataContext setMUODataContext(IMUODataContext muoDataContext) {
//        return this.service.setMUODataContext(muoDataContext);
//    }

    public boolean isAuthorized() {
        return this.service.isAuthorized();
    }

    public void setAuthorized(boolean authorized) {
        this.service.setAuthorized(authorized);
    }

//    public void reset() {
//        this.contributionMetaDataStack = new Stack();
//        this.service.reset();
//    }

    public static DataContextManager current() {
        DataContextManager obj = (DataContextManager) currentBus.get();
        if (null == obj) {
            obj = new DataContextManager();
            currentBus.set(obj);
        }
        obj.service = DataContextService.current();
        return obj;
    }

//    public void pushContributionMetaData(ContributionMetaData contributionMetaData) {
//        this.contributionMetaDataStack.push(contributionMetaData);
//    }

//    public ContributionMetaData popContributionMetaData() {
//        try {
//            return (ContributionMetaData) this.contributionMetaDataStack.pop();
//        } catch (Exception e) {
//        }
//        return null;
//    }

//    public ContributionMetaData getContributionMetaData() {
//        try {
//            return (ContributionMetaData) this.contributionMetaDataStack.peek();
//        } catch (Exception e) {
//        }
//        return null;
//    }
}
