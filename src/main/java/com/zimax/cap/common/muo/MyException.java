package com.zimax.cap.common.muo;

/**
 * @Author 施林丰
 * @Date:2024/7/28 17:53
 * @Description
 */
public class MyException extends RuntimeException{
    private Integer code;
    public MyException(String message){
        super(message);
    }
    public MyException(Integer code,String message){
        super(message);
        this.code = code;
    }
}
