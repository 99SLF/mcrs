package com.zimax.cap.datacontext;

import java.util.HashMap;
import java.util.Locale;

/**
 * 数据上下文服务
 *
 * @author 苏尚文
 * @date 2022/12/3 11:52
 */
public class DataContextService extends HashMap {

    private static final long serialVersionUID = 1L;

    protected static ThreadLocal currentBus = new ThreadLocal();

//    protected ContextStackImpl stack = new ContextStackImpl();

    protected IMapContextFactory mapContextFactory = null;

    private Locale _MES_Current_Locale = null;

    /**
     * MUO数据上下文
     */
    private IMUODataContext muoDataContext;

    private boolean authorized = false;

//    static {
//        registerSerializationHandler();
//        registerObjectAccessor();
//    }

//    private static void registerSerializationHandler() {
//        SerializationHandlerRegistry
//                .registerHandler(new HttpSessionSerializationHandler());
//        SerializationHandlerRegistry
//                .registerHandler(new DataContextSerializationHandler());
//    }

//    private static void registerObjectAccessor() {
//        ObjectAccessorRegistry
//                .registerObjectAccessor(new HttpPageContextAccessor());
//        ObjectAccessorRegistry
//                .registerObjectAccessor(new HttpSessionAccessor());
//        ObjectAccessorRegistry
//                .registerObjectAccessor(new HttpServletContextAccessor());
//        ObjectAccessorRegistry
//                .registerObjectAccessor(new HttpServletRequestAccessor());
//    }

//    public void setCurrentLocale(Locale currentLocale) {
//        this._MES_Current_Locale = currentLocale;
//        CurrentLocaleHelper.setCurrentLocale(currentLocale);
//    }

    public Locale getCurrentLocale() {
        return this._MES_Current_Locale;
    }

    /**
     * 重置数据上下文服务
     */
    public void reset() {
        this.authorized = false;
//        this.stack = new ContextStackImpl();
        this.mapContextFactory = null;

        this._MES_Current_Locale = null;
    }

    /**
     * 获取当前的数据上下文服务
     *
     * @return 数据上下文服务
     */
    public static DataContextService current() {
        DataContextService obj = (DataContextService) currentBus.get();
        if (obj == null) {
            obj = new DataContextService();
            currentBus.set(obj);
        }
        return obj;
    }

//    public ContextStack getContextStack() {
//        return this.stack;
//    }

//    public IDataContext getDefaultContext() {
//        IDataContext ctx;
//        try {
//            ctx = this.stack.peek();
//        } catch (EmptyStackException e) {
//            ctx = DataContextFactory.create("ROOT_CTX");
//            this.stack.push(ctx);
//        }
//        return ctx;
//    }

//    public IApplicationMap getApplicationCtx() {
//        return getMapContextFactory().getApplicationMap();
//    }

//    public IParameterMap getParameterCtx() {
//        return getMapContextFactory().getParameterMap();
//    }

    public IRequestMap getRequestCtx() {
        return getMapContextFactory().getRequestMap();
    }

    public ISessionMap getSessionCtx() {
        return getMapContextFactory().getSessionMap();
    }

//    public IPageMap getPageCtx(PageContext pageContext) {
//        return getMapContextFactory().getPageMap(pageContext);
//    }

    public IMapContextFactory getMapContextFactory() {
        if (null == this.mapContextFactory) {
            this.mapContextFactory = new DefaultMapContextFactory();
        }
        return this.mapContextFactory;
    }

    public void setMapContextFactory(IMapContextFactory mapContextFactory) {
        this.mapContextFactory = mapContextFactory;
    }

    /**
     * 获取MUO数据上下文
     *
     * @return MUO数据上下文
     */
    public IMUODataContext getMUODataContext() {
        return this.muoDataContext;
    }

    /**
     * 设置MUO数据上下文
     *
     * @param muoDataContext MUO数据上下文
     * @return 旧的MUO数据上下文
     */
    public IMUODataContext setMUODataContext(IMUODataContext muoDataContext) {
        IMUODataContext old = this.muoDataContext;
        this.muoDataContext = muoDataContext;
        return old;
    }

    public boolean isAuthorized() {
        return this.authorized;
    }

    public void setAuthorized(boolean authorized) {
        this.authorized = authorized;
    }
}
