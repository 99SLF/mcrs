package com.zimax.cap.datacontext;

import java.util.Map;

/**
 * @author 苏尚文
 * @date 2022/12/3 16:17
 */
public abstract class MapDataContextImpl extends DataContextImpl {

    private static final long serialVersionUID = -4574584302266911415L;

    public static String getRootObjectPath(String xpath) {
        if (xpath.charAt(0) == '/') {
            xpath = xpath.substring(1);
        }
        StringBuffer result = new StringBuffer();
        char[] chars = xpath.toCharArray();
        int i = 0;
        for (int length = chars.length; i < length; i++) {
            switch (chars[i]) {
                case '/':
                    return result.toString();
                case '[':
                    return result.toString();
                case '.':
                    int code = chars[(i + 1)];
                    if ((code > 48) && (code <= 57)) {
                        return result.toString();
                    }
                    break;
            }
            result.append(chars[i]);
        }
        return xpath;
    }

    public Object get(Object key) {
        return get(key.toString());
    }

    public Object put(Object key, Object value) {
        Object old = get(key.toString());
//        set(key.toString(), value);
        return old;
    }

    public void putAll(Map t) {
        for (Object obj : t.entrySet()) {
            Map.Entry entry = (Map.Entry) obj;
            put(entry.getKey(), entry.getValue());
        }
    }

    public Object remove(Object key) {
        Object old = get(key);
//        deleteObject(key.toString());
        return old;
    }
}
