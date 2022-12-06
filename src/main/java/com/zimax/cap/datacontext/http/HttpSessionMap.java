package com.zimax.cap.datacontext.http;

import com.zimax.cap.datacontext.ISessionMap;
import com.zimax.cap.datacontext.MapDataContextImpl;
import com.zimax.cap.party.IUserObject;
import com.zimax.cap.party.impl.UserObject;

import javax.servlet.http.HttpSession;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Set;

/**
 * @author 苏尚文
 * @date 2022/12/5 14:51
 */
public class HttpSessionMap extends MapDataContextImpl implements ISessionMap {

    private static final long serialVersionUID = 1092525504299222532L;

    private HttpSession session = null;

    protected Object rootObject = null;

    public HttpSessionMap(HttpSession session) {
//        addTypeMapping("xpath:/userObject", "java:" + UserObject.class.getName());

        this.rootObject = session;
        this.session = session;
    }

    public HttpSession getHttpSession() {
        return (HttpSession) this.rootObject;
    }

    public void clear() {
        Enumeration enm = this.session.getAttributeNames();
        while (enm.hasMoreElements()) {
            this.session.removeAttribute((String) enm.nextElement());
        }
    }

    public boolean containsKey(Object key) {
        Enumeration enm = this.session.getAttributeNames();
        while (enm.hasMoreElements()) {
            if (enm.nextElement().equals(key)) {
                return true;
            }
        }
        return false;
    }

    public boolean containsValue(Object value) {
        Enumeration enm = this.session.getAttributeNames();
        while (enm.hasMoreElements()) {
            Object attributeValue = this.session.getAttribute((String) enm.nextElement());
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
        return !this.session.getAttributeNames().hasMoreElements();
    }

    public Set keySet() {
        Set ret = new HashSet();
        Enumeration enm = this.session.getAttributeNames();
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
        Enumeration enm = this.session.getAttributeNames();
        while (enm.hasMoreElements()) {
            ret.add(this.session.getAttribute((String) enm.nextElement()));
        }
        return ret;
    }

    public void writeRootObject(String xpath, boolean delete) {
        String key = getRootObjectPath(xpath);
        if ((delete) && (!containsKey(key))) {
            return;
        }
        Object object = this.session.getAttribute(key);
        this.session.setAttribute(key, object);
    }

    public IUserObject getUserObject() {
        Object result = get("userObject");
        if (result == null) {
            return (IUserObject) result;
        }
        if (!IUserObject.class.isAssignableFrom(result.getClass())) {
            throw new IllegalArgumentException("the key is 'userObject',but value is '" + result.getClass() + "'");
        }
        return (IUserObject) result;
    }

    @Override
    public Object getRootObject() {
        return rootObject;
    }
}
