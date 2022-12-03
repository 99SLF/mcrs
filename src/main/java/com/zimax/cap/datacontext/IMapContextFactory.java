package com.zimax.cap.datacontext;

import com.zimax.cap.party.IUserObject;
import com.zimax.cap.party.impl.UserObject;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * @author 苏尚文
 * @date 2022/12/3 14:52
 */
public interface IMapContextFactory {

    IRequestMap getRequestMap();

    ISessionMap getSessionMap();

//    IApplicationMap getApplicationMap();

//    IParameterMap getParameterMap();

//    IPageMap getPageMap(PageContext paramPageContext);

    public static class DefaultMapDataContextImpl
            extends MapDataContextImpl
            implements IRequestMap, ISessionMap {

        private static final long serialVersionUID = 529266349559205279L;

        private Map values = new HashMap();

        public DefaultMapDataContextImpl() {
//            addTypeMapping("xpath:/userObject", "java:" + UserObject.class.getName());

//            setRootObject(this.values);
        }

        public Map getParameters() {
            return this.values;
        }

        public void clear() {
            this.values.clear();
        }

        public boolean containsKey(Object key) {
            return this.values.containsKey(key);
        }

        public boolean containsValue(Object value) {
            return this.values.containsValue(value);
        }

        public Set entrySet() {
            return this.values.entrySet();
        }

        public Object get(Object key) {
            return this.values.get(key);
        }

        public boolean isEmpty() {
            return this.values.isEmpty();
        }

        public Set keySet() {
            return this.values.keySet();
        }

        public Object put(Object key, Object value) {
            return this.values.put(key, value);
        }

        public void putAll(Map t) {
            this.values.putAll(t);
        }

        public Object remove(Object key) {
            return this.values.remove(key);
        }

        public int size() {
            return this.values.size();
        }

        public Collection values() {
            return this.values.values();
        }

        private UserObject userObject = new UserObject();

        public IUserObject getUserObject() {
            return this.userObject;
        }

        @Override
        public Object getRootObject() {
            return null;
        }
    }
}
