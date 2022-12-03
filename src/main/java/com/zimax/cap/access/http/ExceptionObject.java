package com.zimax.cap.access.http;

import javax.servlet.http.HttpServletRequest;

/**
 * 异常对象
 *
 * @author 苏尚文
 * @date 2022/12/3 9:54
 */
public class ExceptionObject {

    private Throwable throwable;

    private boolean invalid;

    private String forwardPage;

    private String requestContext;

    private boolean needForward;

    /**
     * @deprecated
     */
    public ExceptionObject() {
        this.requestContext = "";
    }

    public ExceptionObject(HttpServletRequest request) {
        this.requestContext = request.getContextPath();
    }

    public boolean isInvalid() {
        return this.invalid;
    }

    public void setInvalid(boolean invalid) {
        this.invalid = invalid;
    }

    public Throwable getThrowable() {
        return this.throwable;
    }

    public void setThrowable(Throwable t) {
        this.throwable = t;
    }

    public void setForwardPage(String forwardPage) {
        this.forwardPage = forwardPage;
    }

    /**
     * @deprecated
     */
    public String getForwardPage() {
        if ((this.forwardPage != null) && (this.forwardPage.trim().length() > 0)) {
            return this.requestContext + this.forwardPage;
        }
        return "";
    }

    public String __getForwardPage() {
        if ((this.forwardPage != null) && (this.forwardPage.trim().length() > 0))
        {
            if (this.needForward) {
                return this.forwardPage;
            }
            return this.requestContext + this.forwardPage;
        }
        return "";
    }

    public boolean isNeedForward() {
        return this.needForward;
    }

    public void setNeedForward(boolean needForward) {
        this.needForward = needForward;
    }
}
