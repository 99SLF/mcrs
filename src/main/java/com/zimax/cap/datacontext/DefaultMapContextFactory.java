package com.zimax.cap.datacontext;

/**
 * @author 苏尚文
 * @date 2022/12/3 16:15
 */
public class DefaultMapContextFactory implements IMapContextFactory {

//    private IApplicationMap app = new IMapContextFactory.DefaultMapDataContextImpl();

    private ISessionMap sess = new IMapContextFactory.DefaultMapDataContextImpl();

    private IRequestMap req = new IMapContextFactory.DefaultMapDataContextImpl();

//    private IParameterMap para = new IMapContextFactory.DefaultMapDataContextImpl();

//    public IApplicationMap getApplicationMap() {
//        return this.app;
//    }

//    public IParameterMap getParameterMap() {
//        return this.para;
//    }

    public IRequestMap getRequestMap() {
        return this.req;
    }

    public ISessionMap getSessionMap() {
        return this.sess;
    }

//    public IPageMap getPageMap(PageContext pageContext) {
//        return new HttpPageMap(pageContext);
//    }
}
