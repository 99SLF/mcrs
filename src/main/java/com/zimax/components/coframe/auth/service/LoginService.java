package com.zimax.components.coframe.auth.service;

import org.springframework.stereotype.Service;

/**
 * 登录验证
 * @author 施林丰
 * @date 2022/11/29
 */
@Service
public class LoginService {

    /**
     * 用户登录
     * @param userId 用户账号
     * @param password 密码
     */
    public void login(String userId, String password) {

    }

    /**
     * 登录验证
     */
   public void authentication(String userId, String password) {
   }

    /**
     * 验证用户是否失效
     */
    public void isEnd(String userId, String password) {

    }

    /**
     * 注销用户
     */
    public void logout() {

    }

    /**
     * 注册用户
     */
    public void register(String userId, String userName, String password, String mobile, String email) {

    }

}
