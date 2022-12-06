package com.zimax.cap.datacontext.http;

import com.zimax.cap.datacontext.DataContextImpl;
import com.zimax.cap.datacontext.IMUODataContext;
import com.zimax.cap.exception.CapRuntimeException;
import com.zimax.cap.party.IUserObject;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * @author 苏尚文
 * @date 2022/12/5 11:54
 */
public class MUODataContext
        extends DataContextImpl
        implements IMUODataContext {

    private static final long serialVersionUID = 2659431348879020570L;

    private Map<String, Integer> managedKeysMap;

    private String[] managedKeys;

    private boolean[] changed;

    protected boolean autoCreateNonexistPath = true;

//    public MUODataContext(String[] managedKeys) {
//        this.autoCreateNonexistPath = false;
//        this.rootObject = new HashMap();
//        this.managedKeys = managedKeys;
//        this.managedKeysMap = new HashMap(managedKeys.length);
//        for (int i = 0; i < managedKeys.length; i++) {
//            String key = managedKeys[i];
//            this.managedKeysMap.put(key, Integer.valueOf(i));
//        }
//        this.changed = new boolean[managedKeys.length];
//    }

    public MUODataContext(HttpSession session, String[] managedKeys) {
        this.autoCreateNonexistPath = false;
        Map map = new HashMap();
        this.managedKeys = managedKeys;
        this.managedKeysMap = new HashMap(managedKeys.length);
        for (int i = 0; i < managedKeys.length; i++) {
            String key = managedKeys[i];
            this.managedKeysMap.put(key, Integer.valueOf(i));
            map.put(key, session.getAttribute(key));
        }
        this.changed = new boolean[managedKeys.length];
        this.rootObject = map;
    }

//    public MUODataContext(Map values, String[] managedKeys) {
//        this.autoCreateNonexistPath = false;
//        Map map = new HashMap();
//        this.managedKeys = managedKeys;
//        this.managedKeysMap = new HashMap(managedKeys.length);
//        for (int i = 0; i < managedKeys.length; i++) {
//            String key = managedKeys[i];
//            this.managedKeysMap.put(key, Integer.valueOf(i));
//            map.put(key, values.get(key));
//        }
//        this.changed = new boolean[managedKeys.length];
//        this.rootObject = map;
//    }

//    public Object createObject(String xpath, Class clazz) {
//        throw new EOSRuntimeException("MUODataContext cannot create value!");
//    }

//    public DataObject createObject(String xpath, Type type) {
//        throw new CapRuntimeException("MUODataContext cannot create value!");
//    }

    public void deleteObject(String xpath) {
        throw new CapRuntimeException("MUODataContext cannot delete value!");
    }

    public void add(String xpath, Object obj) {
        throw new CapRuntimeException("MUODataContext cannot add value!");
    }

    public Object get(String xpath) {
        Integer i = getManagedKeyIndex(xpath);
        if (i != null) {
            return super.get(xpath);
        }
        return null;
    }

    public void set(String xpath, Object obj) {
        Integer i = getManagedKeyIndex(xpath);
        if (i != null) {
            super.set(xpath, obj);
            this.changed[i.intValue()] = true;
        }
    }

    private Integer getManagedKeyIndex(String xpath) {
        if ((xpath == null) || (xpath.equals(""))) {
            return null;
        }
        String key = null;
        int startIndex = 0;
        int endIndex = xpath.length();
        if (xpath.charAt(0) == '/') {
            startIndex = 1;
            endIndex = xpath.indexOf('/', 1);
        } else {
            startIndex = 0;
            endIndex = xpath.indexOf('/');
        }
        key = xpath.substring(startIndex, endIndex < 0 ? xpath.length() : endIndex);
        if (key.endsWith("]")) {
            endIndex = key.indexOf("[");
            if (endIndex > 0) {
                key = key.substring(0, endIndex);
            }
        }
        int dotIdx = key.indexOf(".");
        if (dotIdx > 0) {
            String suffix = key.substring(dotIdx + 1);
            try {
                Integer.parseInt(suffix);
                key = key.substring(0, dotIdx);
            } catch (Throwable e) {
            }
        }
        return (Integer) this.managedKeysMap.get(key);
    }

    public boolean[] keysIsChanged() {
        return this.changed;
    }

    public String[] getManagedKeys() {
        return this.managedKeys;
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
}
