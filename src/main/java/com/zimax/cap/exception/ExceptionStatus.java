package com.zimax.cap.exception;

import com.zimax.cap.utility.StringUtil;

import java.io.Serializable;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.Locale;
import java.util.Set;

/**
 * 异常状态
 *
 * @author 苏尚文
 * @date 2022/12/3 10:07
 */
public class ExceptionStatus implements Serializable {

    private static final long serialVersionUID = -7021028067279879985L;

    private String _code;

    private String _message;

    public Object[] _params;

    private Throwable _exception = null;

    private Set<Throwable> _childrenException = new LinkedHashSet();

    private static final String ERROR_CODE = "ErrCode: ";

    private static final String ERROR_MESSAGE = "Message: ";

    public ExceptionStatus(String code) {
        this(code, null, null, null);
    }

    public ExceptionStatus(String code, String message) {
        this(code, message, null, null);
    }

    public ExceptionStatus(String code, Object[] params) {
        this(code, null, null, params);
    }

    public ExceptionStatus(String code, String message, Object[] params) {
        this(code, message, null, params);
    }

    public ExceptionStatus(String code, Throwable exception) {
        this(code, null, exception, null);
    }

    public ExceptionStatus(String code, Throwable exception, Object[] params) {
        this(code, null, exception, params);
    }

    public ExceptionStatus(String code, String message, Throwable exception) {
        this(code, message, exception, null);
    }

    public ExceptionStatus(String code, String message, Throwable exception, Object[] params) {
        setCode(code);
        setMessage(message);
        setParams(params);
        setException(exception);
    }

    public Object[] getParams() {
        return this._params;
    }

    public void setParams(Object[] params) {
        this._params = params;
    }

    public Throwable getException() {
        return this._exception;
    }

    protected void setException(Throwable exception) {
        this._exception = exception;
    }

    public void setMessage(String message) {
        this._message = message;
    }

    public String getMessage() {
        return this._message;
    }

    public void setCode(String code) {
        this._code = code;
    }

    public String getCode() {
        return this._code;
    }

    public void addChild(Throwable exception) {
        if (exception == null) {
            return;
        }
        this._childrenException.add(exception);
    }

    public void addChild(Throwable[] exceptions) {
        if (exceptions == null) {
            return;
        }
        this._childrenException.addAll(Arrays.asList(exceptions));
    }

    public int getChildSize() {
        return this._childrenException.size();
    }

    public Throwable[] getChildren() {
        return (Throwable[])this._childrenException.toArray(new Throwable[0]);
    }

    public String toString() {
        return getLocalizedMessage(Locale.getDefault());
    }

    public String getLocalizedMessage(Locale locale) {
        StringBuffer sb = new StringBuffer();
        sb.append(toMessage(locale));
        for (Throwable child : this._childrenException) {
            sb.append("\n").append(child.getMessage());
        }
        return sb.toString();
    }

    public String toMessage(Locale locale) {
        StringBuffer messageBuffer = new StringBuffer();
        if (this._code != null) {
            messageBuffer.append("ErrCode: ").append(this._code).append("\n");
        }
        String resourceMessage = getMessageOnly(locale);
        if ((resourceMessage != null) && (resourceMessage.length() > 0)) {
            messageBuffer.append("Message: ").append(resourceMessage);
        }
        return messageBuffer.toString();
    }

    public String getMessageOnly(Locale locale) {
        StringBuffer messageBuffer = new StringBuffer();
//        String resourceMessage = ResourceMessageUtil.getExceptionResourceMessage(this._code, locale);
        String resourceMessage = this._code;
        if ((resourceMessage != null) && (resourceMessage.length() > 0)) {
            messageBuffer.append(resourceMessage);
        }
        if ((this._message != null) && (this._message.length() > 0)) {
            messageBuffer.append('(').append(this._message).append(')');
        }
        if (messageBuffer.length() == 0) {
            messageBuffer.append("NULL");
        }
        String messageOld = messageBuffer.toString();
        try {
            return StringUtil.format(messageOld, this._params);
        } catch (Throwable t) {
            for (Object p : this._params) {
                messageBuffer.append('{').append(p).append('}');
            }
        }
        return messageBuffer.toString();
    }
}
