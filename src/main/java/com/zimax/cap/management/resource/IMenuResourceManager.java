package com.zimax.cap.management.resource;

/**
 * @author 苏尚文
 * @date 2022/12/6 17:08
 */
public interface IMenuResourceManager {

    String getResourceURI(String paramString);

    boolean canAccess(String[] paramArrayOfString);

}
