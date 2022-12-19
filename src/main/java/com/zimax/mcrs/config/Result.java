package com.zimax.mcrs.config;

/**
 * 接口返回统一
 * @author 施林丰
 * @date 2022/11/29
 */

public class Result<T> {
    private String code;
    private String msg;
    private T data;
    private Integer total;

    /**
     * 获取状态码
     */
    public String getCode() {
        return code;
    }
    /**
     *   获取记录数
     */
    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    /**
     * 设置状态码
     */
    public void setCode(String code) {
        this.code = code;
    }

    /**
     * 获取返回的消息
     */
    public String getMsg() {
        return msg;
    }

    /**
     * 设置返回的消息
     */
    public void setMsg(String msg) {
        this.msg = msg;
    }

    /**
     * 获取返回的数据
     */
    public T getData() {
        return data;
    }


    /**
     * 设置数据
     */
    public void setData(T data) {
        this.data = data;
    }

    /**
     * 无参构造
     */
    public Result() {
    }

    /**
     * 有参构造
     */
    public Result(T data,Integer total) {
        this.data = data;
        this.total = total;
    }
    public Result(T data) {
        this.data = data;
    }
    public static Result success() {
        Result result = new Result<>();
        result.setCode("0");
        result.setMsg("成功");

        return result;
    }
    public static <T> Result<T> success(T data,Integer total) {
        Result<T> result = new Result<>(data,total);
        result.setCode("0");
        result.setMsg("成功");
        return result;
    }
    public static <T> Result<T> success(T data) {
        Result<T> result = new Result<>(data);
        result.setCode("0");
        result.setMsg("成功");
        return result;
    }

    public static Result error(String code, String msg) {
        Result result = new Result();
        result.setCode(code);
        result.setMsg(msg);
        return result;
    }
    public static Result error() {
        Result result = new Result();
        result.setCode("1");
        result.setMsg("失败");
        return result;
    }

    /**
     * 假设有异常，将异常信息传递给构造方法
     * @param
     * @return
     */
    public Result(Throwable e){

        this.msg = e.getMessage();

    }

    public Result(String code,T data){
        this.code=code;
        this.data=data;
    }
}
