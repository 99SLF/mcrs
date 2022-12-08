package com.zimax.cap.management.resource.impl;

import com.zimax.cap.management.resource.IManagedResource;
import com.zimax.cap.management.resource.IResourceChangeEvent;

/**
 * @author 苏尚文
 * @date 2022/12/6 16:45
 */
public class DefaultResourceChangeEvent implements IResourceChangeEvent {

    private int changeType;

    private IManagedResource oldResource;

    private IManagedResource newResource;

    public DefaultResourceChangeEvent(int changeType,
                                      IManagedResource oldResource, IManagedResource newResource) {
        this.changeType = changeType;
        this.oldResource = oldResource;
        this.newResource = newResource;
    }

    public int getChangeType() {
        return this.changeType;
    }

    public IManagedResource getNewValue() {
        return this.newResource;
    }

    public IManagedResource getOldValue() {
        return this.oldResource;
    }
}
