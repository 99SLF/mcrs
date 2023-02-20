package com.zimax.components.websocket;

import com.alibaba.fastjson.JSON;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/2/17 10:36
 */
public class Util {


    public static JSONObject toJson(String jsonString) {
        try {
            return new JSONObject(jsonString);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }


    @SuppressWarnings({ "rawtypes", "unchecked" })
    public static Map toMap(JSONObject jsonObject) {
        Map result = new HashMap();
        if (jsonObject == null) {
            return result;
        }
        for (Iterator iterator = jsonObject.keys(); iterator.hasNext();) {
            Object key = iterator.next();
            try {
                result.put(key, jsonObject.get(key.toString()));
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        return result;
    }


    public static Object transform(Object value) {
        if (value == null) {
            return value;
        }
        if (Date.class.isAssignableFrom(value.getClass())) {
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return df.format((Date) value);
        } else if (isJSON((String) value)) {
            return value;
        } else {
            return toJson((String) value);
        }
    }


    public static boolean isJSON(String str) {
        boolean result = false;
        try {
            Object obj = JSON.parse(str);
            result = true;
        } catch (Exception e) {
            result = false;
        }
        return result;
    }
}
