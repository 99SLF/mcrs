package com.zimax.components.coframe.rights.controller;

import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.components.coframe.rights.service.UserService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户管理
 * @author 李伟杰
 * @date 2022/11/28
 */
@RestController
@RequestMapping("/user")
public class UserController {

    //用户服务
    @Autowired
    private UserService userService;

    /**
     * 添加用户
     * @param user 用户信息
     * @return
     */
    @RequestMapping("/addUser")
    public Result<?> addUser(@RequestBody User user) {
        return Result.success();
    }

    /**
     * 重置密码
     * @param user     用户
     * @param password 新密码
     */
    @PostMapping("/changePassword/{password}")
    @ResponseBody
    public Result<?> changePassword(@RequestBody User user, @PathVariable("password") String password) {
        return Result.success();

    }

    /**
     * 检测用户是否存在
     * @param userId 用户名字
     */
    @RequestMapping(value = "/checkUser/{userId}", method = RequestMethod.GET)
    public boolean checkUser(@PathVariable("userId") String userId) {
        return false;
    }

    /**
     * 删除用户信息
     * @param users 用户数组
     */
    @DeleteMapping("/deleteUsers}")
    public void deleteUsers(@RequestParam(value = "users") List<User> users) {
    }

    /**
     * 模板查询用户信息
     * @param template 查询用户
     * @return user 用户详细
     */
    @GetMapping("/getCapUser")
    public Result<?> getCapUser(@RequestBody User template) {
        return Result.success();
    }

    /**
     * 根据用户模板获得完整用户信息
     * @param user 用户模板信息
     * @return user 用户信息
     */
    @GetMapping("/getUser")
    public Result<?> getUser(@RequestBody User user) {
        return Result.success();

    }

    /**
     * 分页查询用户
     * @param status   用户状态
     * @param userName 用户名
     * @param limit    页码
     * @param page     页记录数
     * @return 用户列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/queryUsers/{status}/{userName}/{limit}/{page}")
    public Result<?> queryUsers(@PathVariable("status") String status, @PathVariable("userName") String userName, @PathVariable("limit") int limit, @PathVariable("page") int page) {
        return Result.success();
    }

    /**
     * 注册用户
     * @param user 用户
     */
    @PostMapping("/registerUser")
    public void registerUser(@RequestBody User user) {

    }

    /**
     * 更新密码
     * @param user     用户
     * @param password 密码
     * @return 状态码
     */
    @RequestMapping("/updatePassword/{password}")
    public Result<?> updatePassword(@RequestBody User user, @PathVariable("password") String password) {
        return Result.success();
    }

    /**
     * 更改多个密码
     * @param users 用户集合
     */
    @PostMapping("/updatePasswords")
    public void updatePasswords(@RequestParam(value = "users") List<User> users) {

    }

    /**
     * 更新用户
     * @param user 用户信息
     * @return
     */
    @PostMapping("/updateUser")
    public void updateUser(User user) {

    }
}
