package com.zimax.cap.access.http;

import com.zimax.cap.exception.CapRuntimeException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Iterator;

/**
 * 异常处理帮助类
 *
 * @author 苏尚文
 * @date 2022/12/3 10:22
 */
public class ThrowableProcessHelper {

    public static void execute(HttpServletRequest request,
                               HttpServletResponse response, ExceptionObject exceptionObj,
                               boolean needForward) throws IOException, ServletException {
        exceptionObj.setNeedForward(needForward);
        String errorPage = exceptionObj.__getForwardPage();
        if (errorPage.length() > 0) {
            if (exceptionObj.isNeedForward()) {
                request.setAttribute("_exception",
                        exceptionObj.getThrowable());
                RequestDispatcher rd = request
                        .getRequestDispatcher(errorPage);
                if (rd != null) {
                    rd.forward(request, response);
                }
            } else {
                response.sendRedirect(errorPage);
            }
        } else {
            if ((exceptionObj.getThrowable() instanceof RuntimeException)) {
                throw ((RuntimeException) exceptionObj.getThrowable());
            }
            throw new CapRuntimeException(exceptionObj.getThrowable());
        }
    }
}
