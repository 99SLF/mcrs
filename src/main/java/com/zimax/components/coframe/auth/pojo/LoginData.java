package com.zimax.components.coframe.auth.pojo;

import lombok.Data;

/**
 * 登录数据
 *
 * @author 苏尚文
 * @date 2022/12/6 9:26
 */
@Data
public class LoginData {

    /**
     * 登录用户名
     */
    public String userId;

    /**
     * 登录密码
     */
    public String password;
}
