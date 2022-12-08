package com.zimax.cap.common.muo.mbean;

import java.io.Serializable;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @author 苏尚文
 * @date 2022/12/7 9:44
 */
public class SessionManagerConfigModel implements IConfigModel {

    private static final long serialVersionUID = 1L;

    private MUOItem muoItem;

    private String userLoginCallback;

    public SessionManagerConfigModel() {
        this.muoItem = new MUOItem();
    }

    public String getUserLoginCallback() {
        return this.userLoginCallback;
    }

    public void setUserLoginCallback(String userLoginCallback) {
        this.userLoginCallback = userLoginCallback;
    }

    public MUOItem getMuoItem() {
        return this.muoItem;
    }

    public void setMuoItem(MUOItem muoItem) {
        this.muoItem = muoItem;
    }

    public static class MUOItem implements Serializable {

        private Map<String, String> map = new LinkedHashMap();

        private Map<String, String> typeMapping;

        public void add(String key, String type) {
            if (this.map.containsKey(key)) {
                throw new IllegalStateException("has contain key '" + key + "'.");
            }
            this.map.put(key, type);
        }

        public void update(String key, String type) {
            this.map.put(key, type);
        }

        public String get(String key) {
            return this.map.get(key);
        }

        public String delete(String key) {
            return this.map.remove(key);
        }

        public String[] keys() {
            return this.map.keySet().toArray(new String[this.map.size()]);
        }

        public Map<String, String> getMap() {
            return this.map;
        }

        public Map<String, String> retrieveTypeMapping() {
            Map<String, String> tmpTypeMapping = new HashMap();
            if (this.typeMapping == null) {
                for (Map.Entry<String, String> entry : this.map.entrySet()) {
                    String key = (String) entry.getKey();
                    if (key.charAt(0) != '/') {
                        key = "/" + key;
                    }
                    key = "xpath:" + key;
                    String value = (String) entry.getValue();
                    if (value.indexOf(":") == -1) {
                        value = "java:" + value;
                    }
                    tmpTypeMapping.put(key, value);
                }
                this.typeMapping = tmpTypeMapping;
            }
            return this.typeMapping;
        }
    }
}
