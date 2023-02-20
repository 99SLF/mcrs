package com.zimax.components.websocket;

import java.util.HashMap;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/2/16 14:42
 */
public class ServiceFactory {
    private static ServiceFactory instance;

    public static ServiceFactory getInstance() {
        if (instance == null) {
            instance = new ServiceFactory();
        }
        return instance;
    }

    private Map<String, IWebSocketService> services = new HashMap<String, IWebSocketService>();

    private Map<String, Integer> intervals = new HashMap<String, Integer>();

    private ServiceFactory() {

    }

    public void addService(String key, IWebSocketService service, int interval) {
        services.put(key, service);
        intervals.put(key, interval);
    }

    public IWebSocketService getService(String key) {
        return services.get(key);
    }

    public int getInterval(String key) {
        return intervals.get(key);
    }
}
