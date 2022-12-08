package com.zimax.cap.management.resource.impl;

import com.zimax.cap.exception.CapRuntimeException;

/**
 * @author 苏尚文
 * @date 2022/12/6 16:46
 */
public class ResourceRuntimeException extends CapRuntimeException {

    private static final long serialVersionUID = -4305520687131175081L;

    public ResourceRuntimeException(String code, Object[] params,
                                    Throwable cause) {
        super(code, params, cause);
    }

    public ResourceRuntimeException(String code, Object[] params) {
        super(code, params);
    }

    public ResourceRuntimeException(String code, String message, Object[] params) {
        super(code, message, params);
    }

    public ResourceRuntimeException(String code, String message) {
        super(code, message);
    }

    public ResourceRuntimeException(String code, Throwable cause) {
        super(code, cause);
    }

    public ResourceRuntimeException(String code) {
        super(code);
    }
}
