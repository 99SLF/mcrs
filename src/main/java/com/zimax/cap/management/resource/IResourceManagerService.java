package com.zimax.cap.management.resource;

import com.zimax.cap.IOrderable;

import java.util.List;

/**
 * @author 苏尚文
 * @date 2022/12/6 16:30
 */
public interface IResourceManagerService extends IOrderable {

    void registerManagedResource(
            IManagedResource paramIManagedResource);

    IManagedResource unRegisterManagedResource(
            String paramString1, String paramString2);

    IManagedResource getManagedResource(
            String[] paramArrayOfString1, String[] paramArrayOfString2);

    List<IManagedResource> getRootManagedResourceListByType(String paramString);

    List<IManagedResource> getChildrenManagedResourceList(
            String[] paramArrayOfString1, String[] paramArrayOfString2);

    List<IManagedResource> getChildrenManagedResourceOfTypeList(
            String[] paramArrayOfString1, String[] paramArrayOfString2);

    String[] getManagedResourceXpath(String paramString1, String paramString2);
}
