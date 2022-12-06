package com.zimax.components.coframe.auth.controller;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.cap.party.impl.UserObject;
import com.zimax.components.coframe.auth.pojo.LoginData;
import com.zimax.components.coframe.auth.service.LoginService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

/**
 * 登录检验
 * @author 施林丰
 * @date 2022/11/29
 */
@RestController
@RequestMapping("/auth")
public class LoginController {

    @Autowired
    private LoginService loginService;

    /**
     * 用户登录
     * @param loginData 登录数据
     */
    @PostMapping("/login")
    public Result<?> login(@RequestBody LoginData loginData) {
        Result<String> result = (Result<String>) loginService.authentication(loginData.getUserId(), loginData.getPassword());
        if (result.getCode() == "0") {
            UserObject userObject = loginService.initUserObject(loginData.getUserId());
            loginService.login(userObject);
            result.setData(userObject.getUniqueId());
            result.setMsg("登录成功");
        }
        return result;
    }

    /**
     * 注销用户
     *
     * @return
     */
    @GetMapping("/logout")
    public Result<?> logout() {
        Result<String> result = new Result<>();

        loginService.logout();

        result.setCode("0");
        result.setMsg("退出成功");
        return result;
    }

    /**
     * 获取SESSION信息
     *
     * @return SESSION信息
     */
    @GetMapping("/session")
    public Result<?> getSession() {
        Result<String> result = new Result<>();

        Object rootObject = DataContextManager.current().getSessionCtx().getRootObject();
        IUserObject userObject = null;
        if ((rootObject instanceof HttpSession)) {
            userObject = (IUserObject) ((HttpSession) rootObject).getAttribute("userObject");
        }
        if (userObject != null) {
            result.setCode("0");
            result.setData(userObject.getUserName());
        } else {
            result.setCode("1");
        }

        return result;
    }

    /**
     * 注册用户
     * @param userId 用户账号
     * @param userName 用户姓名
     * @param password 密码
     * @param mobile 手机号
     * @param email 邮箱
     */
    public Result<?> register(String userId, String userName, String password, String mobile, String email) {
        loginService.register(userId, userName, password, mobile, email);
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
