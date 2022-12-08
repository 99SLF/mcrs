package com.zimax.cap.management.resource.manager;

import com.zimax.cap.management.resource.IMenuResourceManager;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author 苏尚文
 * @date 2022/12/6 17:08
 */
public class ResourceConfigurationManager {

    private static ResourceConfigurationManager instance = null;

    private Map<String, IMenuResourceManager> managerMap = new ConcurrentHashMap();

    private Map<String, String> nameMap = new ConcurrentHashMap();

    public IMenuResourceManager getMenuResourceManager(String resourceType) {
        if ((resourceType == null) || (resourceType.trim().length() == 0)) {
            return null;
        }
        return (IMenuResourceManager) this.managerMap.get(resourceType);
    }

    public void putMenuResourceManager(String resourceType,
                                       IMenuResourceManager managerObj) {
        if ((resourceType == null) || (resourceType.trim().length() == 0)) {
            throw new IllegalArgumentException("resourceType is null!");
        }
        if (managerObj == null) {
            throw new IllegalArgumentException("MenuResourceManager is null!");
        }
        this.managerMap.put(resourceType, managerObj);
    }

    public void removeMenuResourceManager(String resourceType) {
        if ((resourceType == null) || (resourceType.trim().length() == 0)) {
            return;
        }
        this.managerMap.remove(resourceType);
    }

    public String getResourceTypeName(String resourceType) {
        if ((resourceType == null) || (resourceType.trim().length() == 0)) {
            return null;
        }
        return (String) this.nameMap.get(resourceType);
    }

    public void putResourceTypeName(String resourceType, String resourceTypeName) {
        if ((resourceType == null) || (resourceType.trim().length() == 0)) {
            throw new IllegalArgumentException("resourceType is null!");
        }
        if ((resourceTypeName == null)
                || (resourceTypeName.trim().length() == 0)) {
            resourceTypeName = "";
        }
        this.nameMap.put(resourceType, resourceTypeName);
    }

    public void removeResourceTypeName(String resourceType) {
        if ((resourceType == null) || (resourceType.trim().length() == 0)) {
            return;
        }
        this.nameMap.remove(resourceType);
    }

    public Map<String, IMenuResourceManager> getMenuResourceManagerMap() {
        return this.managerMap;
    }

    public Map<String, String> getNameMap() {
        return this.nameMap;
    }

    public static ResourceConfigurationManager getInstance() {
        if (instance == null) {
            instance = new ResourceConfigurationManager();
        }
        return instance;
    }
}
