package com.zimax.cap.exception;

import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Locale;

/**
 * CAP异常
 *
 * @author 苏尚文
 * @date 2022/12/3 10:16
 */
public class CapException extends Exception {

    private static final long serialVersionUID = 5822836745567626046L;

    private static final String DEFAULT_CODE = "10000000";

    private ExceptionStatus status;

    /**
     * @deprecated
     */
    public CapException() {
        this("10000000");
    }

    public CapException(String code) {
        this.status = new ExceptionStatus(code);
    }

    public CapException(String code, Object[] params) {
        this.status = new ExceptionStatus(code, params);
    }

    public CapException(String code, String message) {
        this.status = new ExceptionStatus(code, message);
    }

    public CapException(String code, String message, Object[] params) {
        this.status = new ExceptionStatus(code, message, params);
    }

    public CapException(String code, Throwable cause) {
        super(cause);
        this.status = new ExceptionStatus(code, cause);
    }

    public CapException(String code, Object[] params, Throwable cause) {
        super(cause);
        this.status = new ExceptionStatus(code, cause, params);
    }

    public CapException(String code, String message, Throwable cause) {
        super(cause);
        this.status = new ExceptionStatus(code, message, cause);
    }

    public CapException(String code, String message, Object[] params,
                        Throwable cause) {
        super(cause);
        this.status = new ExceptionStatus(code, message, cause, params);
    }

    public CapException(Throwable cause) {
        super(cause);
        this.status = new ExceptionStatus("10000000", cause);
    }

    public void addChild(Throwable exception) {
        this.status.addChild(exception);
    }

    public void addAllChild(Throwable exception) {
        if (exception == null) {
            return;
        }
        if ((exception instanceof CapException)) {
            this.status.addChild(((CapException) exception).getChildren());
        } else if ((exception instanceof CapRuntimeException)) {
            this.status.addChild(((CapRuntimeException) exception)
                    .getChildren());
        } else {
            this.status.addChild(exception);
        }
    }

    public Throwable[] getChildren() {
        return this.status.getChildren();
    }

    public String getCode() {
        return this.status.getCode();
    }

    public boolean isMultiException() {
        return this.status.getChildSize() > 0;
    }

    public Object[] getParams() {
        return this.status.getParams();
    }

    public Throwable getException() {
        return this.status.getException();
    }

    public void printStackTrace() {
        printStackTrace(System.err);
    }

    public String getStackTraceMessage() {
        StringWriter sw = new StringWriter();
        printStackTrace(new PrintWriter(sw));
        return sw.toString();
    }

    public String getStackTraceWithoutMessage() {
        StringWriter sw = new StringWriter();
        printStackTraceWithoutMessage(new PrintWriter(sw));
        return sw.toString();
    }

    private void printStackTraceWithoutMessage(PrintWriter s) {
        synchronized (s) {
            StackTraceElement[] trace = getStackTrace();
            for (int i = 0; i < trace.length; i++) {
                s.println("\tat " + trace[i]);
            }
            Throwable ourCause = getCause();
            if (ourCause != null) {
                s.print("Caused by: ");
                ourCause.printStackTrace(s);
            }
            if (isMultiException()) {
                s.println("ChildException : ");
                for (Throwable child : this.status.getChildren()) {
                    s.print("  ");
                    child.printStackTrace(s);
                }
            }
        }
    }

    public void printStackTrace(PrintStream output) {
        synchronized (output) {
            super.printStackTrace(output);
            if (isMultiException()) {
                output.println("ChildException : ");
                for (Throwable child : this.status.getChildren()) {
                    output.print("  ");
                    child.printStackTrace(output);
                }
            }
        }
    }

    public void printStackTrace(PrintWriter output) {
        synchronized (output) {
            super.printStackTrace(output);
            if (isMultiException()) {
                output.println("ChildException : ");
                for (Throwable child : this.status.getChildren()) {
                    output.print("  ");
                    child.printStackTrace(output);
                }
            }
        }
    }

    public String getMessage() {
        return this.status.getLocalizedMessage(Locale.getDefault());
    }

    public String getLocalizedMessage(Locale locale) {
        return this.status.getLocalizedMessage(locale);
    }

    public String getMessageOnly(Locale locale) {
        return this.status.getMessageOnly(locale);
    }

    public String toString() {
        return getMessage();
    }
}
