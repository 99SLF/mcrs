package com.zimax.components.coframe.auth.controller;

import com.zimax.components.coframe.auth.service.AuthService;
import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.bind.DataObjectPropertyName;
import org.springframework.web.bind.annotation.*;

/**
 * 登录检验
 * @author 施林丰
 * @date 2022/11/29
 */
@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    AuthService authService;

    /**
     * 用户登录
     * @param userId 用户账号
     * @param password 密码
     */
    @RequestMapping("/login")
    public Result<?> login(@RequestParam String userId, String password) {
        authService.login(userId,password);
        return null;
    }

    /**
     * 注销用户
     */
    public Result<?> logout(){
        authService.logout();
        return null;
    }

    /**
     * 注册用户
     * @param userId 用户账号
     * @param userName 用户姓名
     * @param password 密码
     * @param mobile 手机号
     * @param email 邮箱
     */
    public Result<?> register(String userId, String userName, String password, String mobile, String email){
        authService.register(userId, userName, password, mobile, email);
        return null;
    }

    /**
     * 角色授权
     * @param roleId 角色编号
     * @param withAuthRole 有权限角色
     * @param noWithAuthRole 无权限角色
     */
    @RequestMapping("/authorize")
    public Result<?> authorize(@RequestParam int roleId, @RequestBody Object withAuthRole[], @RequestBody Object noWithAuthRole[]) {
        return null;
    }

}
