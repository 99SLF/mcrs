package com.zimax.cap.common.muo;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.servlet.ServletException;
import java.security.PublicKey;

/**
 * @Author 施林丰
 * @Date:2024/7/28 18:10
 * @Description
 */
@RestControllerAdvice
public class MyGlobalExceptionHandler {

    @ExceptionHandler({MyException.class})
    public String myexception(MyException e){
        return "越界";
    }
    @ExceptionHandler(value = ArithmeticException.class)
    public String mexception(ArithmeticException e){
        return "算误";
    }
    @ExceptionHandler({Exception.class})
    public String exception(MyException e){
        return "网络问题";
    }
}
