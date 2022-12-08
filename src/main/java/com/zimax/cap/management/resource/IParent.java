package com.zimax.cap.management.resource;

import java.util.List;

/**
 * @author 苏尚文
 * @date 2022/12/6 16:22
 */
public interface IParent {

    List<IManagedResource> getChildren();

    List<IManagedResource> getChildrenOfType(String paramString);

    boolean hasChildren();

}
