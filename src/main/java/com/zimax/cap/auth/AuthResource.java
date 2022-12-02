package com.zimax.cap.auth;

import java.io.Serializable;
import java.util.Objects;

/**
 * 授权资源
 *
 * @author 苏问文
 * @date 2022-12-02
 */
public class AuthResource implements Serializable {

    private static final long serialVersionUID = 5969268430234954866L;

    /**
     * 资源编号
     */
    private String resourceId;

    /**
     * 资源类型
     */
    private String resourceType;

    /**
     * 状态
     */
    private String state;

    public AuthResource() {
    }

    public AuthResource(String resourceId, String resourceType) {
        this.resourceId = resourceId;
        this.resourceType = resourceType;
    }

    public AuthResource(String resourceId, String resourceType, String state) {
        this(resourceId, resourceType);
        this.state = state;
    }

    public String getResourceId() {
        return this.resourceId;
    }

    public void setResourceId(String resourceId) {
        this.resourceId = resourceId;
    }

    public String getResourceType() {
        return this.resourceType;
    }

    public void setResourceType(String resourceType) {
        this.resourceType = resourceType;
    }

    public String getState() {
        return this.state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public boolean equals(Object other) {
        AuthResource otherNode = (AuthResource) other;
        if ((Objects.equals(this.resourceId, otherNode.resourceId))
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
                + (this.resourceId == null ? 0 : this.resourceId.hashCode());
        result = 31
                * result
                + (this.resourceType == null ? 0 : this.resourceType.hashCode());
        return result;
    }
}
