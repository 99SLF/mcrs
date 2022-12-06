package com.zimax.cap.access.http;

import com.zimax.cap.datacontext.IMapContextFactory;
import com.zimax.cap.datacontext.IRequestMap;
import com.zimax.cap.datacontext.ISessionMap;
import com.zimax.cap.datacontext.http.HttpRequestMap;
import com.zimax.cap.datacontext.http.HttpSessionMap;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @author 苏尚文
 * @date 2022/12/5 14:43
 */
public class HttpMapContextFactory
        implements IMapContextFactory {

    private ServletRequest request = null;

    protected IRequestMap requestCtx = null;

    protected ISessionMap sessionCtx = null;

//    protected IApplicationMap applicationCtx = null;

//    protected IParameterMap parameterCtx = null;

    public HttpMapContextFactory(ServletRequest request, ServletResponse response) {
        this.request = request;
        this.requestCtx = new HttpRequestMap(request);
        if ((request instanceof HttpServletRequest)) {
            HttpSession session = ((HttpServletRequest) request).getSession();
            this.sessionCtx = new HttpSessionMap(session);
//            this.applicationCtx = new HttpApplicationMap(session.getServletContext());
        }
    }

//    public IApplicationMap getApplicationMap() {
//        return this.applicationCtx;
//    }

//    public IParameterMap getParameterMap() {
//        if (this.parameterCtx == null) {
//            this.parameterCtx = new HttpParameterMap(this.request.getParameterMap());
//        }
//        return this.parameterCtx;
//    }

    public IRequestMap getRequestMap() {
        return this.requestCtx;
    }

    public ISessionMap getSessionMap() {
        return this.sessionCtx;
    }

//    public IPageMap getPageMap(PageContext pageContext) {
//        return new HttpPageMap(pageContext);
//    }
}
