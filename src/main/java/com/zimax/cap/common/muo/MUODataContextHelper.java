package com.zimax.cap.common.muo;

import com.zimax.cap.datacontext.IMapContextFactory;

/**
 * @author 苏尚文
 * @date 2022/12/3 14:50
 */
public class MUODataContextHelper {

//    private static void addTypeMapping(MUODataContext dataContext) {
//        SessionManagerConfigModel model = MUOConfig.getInstance().getModel();
//        Map<String, String> typeMapping = model.getMuoItem()
//                .retrieveTypeMapping();
//        dataContext.setTypeMappings(typeMapping);
//        dataContext.setAutoCreatePath(true);
//    }

//    public static IMUODataContext create(HttpSession session) {
//        SessionManagerConfigModel model = MUOConfig.getInstance().getModel();
//        String[] managedKeys = model.getMuoItem().keys();
//        MUODataContext dataContext = new MUODataContext(session, managedKeys);
//        addTypeMapping(dataContext);
//        return dataContext;
//    }

//    public static IMUODataContext create(Map map) {
//        SessionManagerConfigModel model = MUOConfig.getInstance().getModel();
//
//        String[] managedKeys = model.getMuoItem().keys();
//        MUODataContext dataContext = new MUODataContext(map, managedKeys);
//        addTypeMapping(dataContext);
//        return dataContext;
//    }

//    public static IMUODataContext create(IDataContext source) {
//        SessionManagerConfigModel model = MUOConfig.getInstance().getModel();
//
//        String[] managedKeys = model.getMuoItem().keys();
//        Map map = new HashMap();
//        for (int i = 0; i < managedKeys.length; i++) {
//            map.put(managedKeys[i], source.get(managedKeys[i]));
//        }
//        MUODataContext dataContext = new MUODataContext(map, managedKeys);
//        addTypeMapping(dataContext);
//        return dataContext;
//    }

//    public static void flush(IMUODataContext muoDataContext, HttpSession session) {
//        boolean[] indexes = muoDataContext.keysIsChanged();
//        String[] managerKeys = muoDataContext.getManagedKeys();
//        for (int i = 0; i < indexes.length; i++) {
//            if (indexes[i] == true) {
//                session.setAttribute(managerKeys[i],
//                        muoDataContext.get(managerKeys[i]));
//            }
//        }
//    }

//    public static void flush(IMUODataContext muoDataContext, IDataContext source) {
//        boolean[] indexes = muoDataContext.keysIsChanged();
//        String[] managerKeys = muoDataContext.getManagedKeys();
//        for (int i = 0; i < indexes.length; i++) {
//            if (indexes[i] == true) {
//                source.set(managerKeys[i], muoDataContext.get(managerKeys[i]));
//            }
//        }
//    }

//    private static final IMapContextFactory NULL_FACTORY = new IMapContextFactory() {
//
//        public IApplicationMap getApplicationMap() {
//            return null;
//        }
//
//        public IPageMap getPageMap(PageContext pageContext) {
//            return null;
//        }
//
//        public IParameterMap getParameterMap() {
//            return null;
//        }
//
//        public IRequestMap getRequestMap() {
//            return null;
//        }
//
//        public ISessionMap getSessionMap() {
//            return null;
//        }
//    };

    private static final ThreadLocal<IMapContextFactory> factoryThread = new ThreadLocal();

//    private static final ThreadLocal<IMUODataContext> muoThread = new ThreadLocal();

//    public static IMapContextFactory bind(IMUODataContext muo) {
//        DataContextService manager = DataContextService.current();
//        IMapContextFactory result = manager.getMapContextFactory();
//        IMUODataContext muoBak = manager.getMUODataContext();
//        manager.setMUODataContext(muo);
//        manager.setMapContextFactory(NULL_FACTORY);
//        factoryThread.set(result);
//        muoThread.set(muoBak);
//        return result;
//    }

//    public static IMUODataContext unbind(IMapContextFactory factory) {
//        DataContextService manager = DataContextService.current();
//        IMUODataContext result = manager.getMUODataContext();
//        manager.setMUODataContext((IMUODataContext) muoThread.get());
//        manager.setMapContextFactory(factory);
//        factoryThread.remove();
//        muoThread.remove();
//        return result;
//    }

    public static IMapContextFactory getMapContextFactory() {
        return (IMapContextFactory) factoryThread.get();
    }

//    public static IMUODataContext getCustomMUO(String type) {
//        Map map = new HashMap();
//        IUserObject userObject = CustomObjectProviderProvider.getProvider()
//                .getVirtualUserObject(type);
//
//        map.put("userObject", userObject);
//        return create(map);
//    }

//    public static SessionManagerConfigModel getSessionManagerConfigModel() {
//        return MUOConfig.getInstance().getModel();
//    }
}
