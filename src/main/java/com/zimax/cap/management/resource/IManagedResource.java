package com.zimax.cap.management.resource;

import com.zimax.cap.IOrderable;

import java.util.Map;

/**
 * @author 苏尚文
 * @date 2022/12/6 16:18
 */
public interface IManagedResource extends IChild, IParent, IOrderable {

    String PUBLIC_AUTH = "__PUBLIC";

    String getResourceID();

    String getResourceType();

    String getResourceCatalog();

    String getResourceName();

    String getResourceDesc();

    String[] getStateList();

    boolean needAuth();

    Map<String, Map<String, IManagedResource>> getChildrenMap();

    void addChildManagedResource(IManagedResource paramIManagedResource);

    IManagedResource removeChildManagedResource(String paramString1, String paramString2);

    void updateChildManagedResource(IManagedResource paramIManagedResource);

    void addAttribute(String paramString1, String paramString2);

    void removeAttribute(String paramString);

    String getAttribute(String paramString);
}
