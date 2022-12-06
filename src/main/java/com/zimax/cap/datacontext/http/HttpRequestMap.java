package com.zimax.cap.datacontext.http;

import com.zimax.cap.datacontext.IRequestMap;
import com.zimax.cap.datacontext.MapDataContextImpl;

import javax.servlet.ServletRequest;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Set;

/**
 * @author 苏尚文
 * @date 2022/12/5 14:46
 */
public class HttpRequestMap extends MapDataContextImpl implements IRequestMap {

    private static final long serialVersionUID = 4774957344085484117L;

    private ServletRequest req = null;

    protected Object rootObject = null;

    public HttpRequestMap(ServletRequest request) {
        this.rootObject = request;
        this.req = request;
    }

    public ServletRequest getRequest() {
        return (ServletRequest) this.rootObject;
    }

    public void clear() {
        Enumeration enm = this.req.getAttributeNames();
        while (enm.hasMoreElements()) {
            this.req.removeAttribute((String) enm.nextElement());
        }
    }

    public boolean containsKey(Object key) {
        Enumeration enm = this.req.getAttributeNames();
        while (enm.hasMoreElements()) {
            if (enm.nextElement().equals(key)) {
                return true;
            }
        }
        return false;
    }

    public boolean containsValue(Object value) {
        Enumeration enm = this.req.getAttributeNames();
        while (enm.hasMoreElements()) {
            Object attributeValue = this.req.getAttribute((String) enm.nextElement());
            if (attributeValue.equals(value)) {
                return true;
            }
        }
        return false;
    }

    public Set entrySet() {
        throw new UnsupportedOperationException();
    }

    public boolean isEmpty() {
        return !this.req.getAttributeNames().hasMoreElements();
    }

    public Set keySet() {
        Set ret = new HashSet();
        Enumeration enm = this.req.getAttributeNames();
        while (enm.hasMoreElements()) {
            ret.add(enm.nextElement());
        }
        return ret;
    }

    public int size() {
        return keySet().size();
    }

    public Collection values() {
        Set ret = new HashSet();
        Enumeration enm = this.req.getAttributeNames();
        while (enm.hasMoreElements()) {
            ret.add(this.req.getAttribute((String) enm.nextElement()));
        }
        return ret;
    }

    public void writeRootObject(String xpath, boolean delete) {
        String key = getRootObjectPath(xpath);
        if ((delete) && (!containsKey(key))) {
            return;
        }
        Object object = this.req.getAttribute(key);
        this.req.setAttribute(key, object);
    }

    @Override
    public Object getRootObject() {
        return rootObject;
    }
}
