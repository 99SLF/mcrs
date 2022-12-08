package com.zimax.cap.management.resource;

/**
 * @author 苏尚文
 * @date 2022/12/6 16:27
 */
public interface IResourceChangeEvent {

    int ADD = 1;

    int REMOVE = 2;

    int UPDATE = 3;

    int getChangeType();

    IManagedResource getOldValue();

    IManagedResource getNewValue();
}
