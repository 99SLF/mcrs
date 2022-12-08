package com.zimax.cap.management.resource.impl;

import java.io.Serializable;
import java.util.Objects;

/**
 * @author 苏尚文
 * @date 2022/12/6 16:34
 */
public class ResourceBean implements Serializable {

    private static final long serialVersionUID = -2693301443157058140L;

    private String resourceID;

    private String resourceType;

    public ResourceBean(String resourceID, String resourceType) {
        this.resourceID = resourceID;
        this.resourceType = resourceType;
    }

    public String getResourceID() {
        return this.resourceID;
    }

    public void setResourceID(String resourceID) {
        this.resourceID = resourceID;
    }

    public String getResourceType() {
        return this.resourceType;
    }

    public void setResourceType(String resourceType) {
        this.resourceType = resourceType;
    }

    public boolean equals(Object other) {
        ResourceBean otherNode = (ResourceBean) other;
        if ((Objects.equals(this.resourceID, otherNode.resourceID))
                && (Objects.equals(this.resourceType,
                otherNode.resourceType))) {
            return true;
        }
        return false;
    }

    public int hashCode() {
        int PRIME = 31;
        int result = 1;
        result = 31 * result
                + (this.resourceID == null ? 0 : this.resourceID.hashCode());
        result = 31
                * result
                + (this.resourceType == null ? 0 : this.resourceType.hashCode());
        return result;
    }
}
