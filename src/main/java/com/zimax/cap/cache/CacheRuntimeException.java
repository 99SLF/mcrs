package com.zimax.cap.cache;

import com.zimax.cap.exception.CapRuntimeException;

/**
 * 缓存运行异常
 *
 * @author 苏尚文
 * @date 2022/12/3 11:11
 */
public class CacheRuntimeException extends CapRuntimeException {

    private static final long serialVersionUID = 1781748799129859783L;

    public CacheRuntimeException(String code) {
        super(code);
    }

    public CacheRuntimeException(String code, Object[] params) {
        super(code, params);
    }

    public CacheRuntimeException(String code, String message) {
        super(code, message);
    }

    public CacheRuntimeException(String code, String message, Object[] params) {
        super(code, message, params);
    }

    public CacheRuntimeException(String code, Throwable cause) {
        super(code, cause);
    }

    public CacheRuntimeException(String code, Object[] params, Throwable cause) {
        super(code, params, cause);
    }

    public CacheRuntimeException(String code, String message, Throwable cause) {
        super(code, message, cause);
    }

    public CacheRuntimeException(String code, String message, Object[] params, Throwable cause) {
        super(code, message, params, cause);
    }

    public CacheRuntimeException(Throwable cause) {
        super(cause);
    }
}
