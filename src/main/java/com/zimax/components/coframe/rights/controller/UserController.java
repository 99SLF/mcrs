package com.zimax.components.coframe.rights.controller;


import com.zimax.components.coframe.rights.pojo.PartyAuth;
import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.components.coframe.rights.pojo.UserPartyAuthVo;
import com.zimax.components.coframe.rights.service.UserService;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfo;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * 用户管理
 *
 * @author 李伟杰
 * @date 2022/11/28
 */
@RestController
@RequestMapping("/user")
public class UserController {

    /**
     * 用户服务
     */
    @Autowired
    private UserService userService;

    /**
     * 添加用户
     *
     * @param user 用户信息
     * @return
     */
    @PostMapping("/add")
    public Result<?> addUser(@RequestBody User user) {
        userService.addUser(user);
        return Result.success();
    }

    /**
     * 更新用户
     *
     * @param user 用户信息
     * @return
     */
    @PostMapping("/update")
    public Result<?> updateUser(@RequestBody User user) {
        userService.updateUser(user);
        return Result.success();
    }

    /**
     * 获取用户
     *
     * @param operatorId 操作员编号
     */
    @GetMapping("/find/{operatorId}")
    public Result<?> getUser(@PathVariable("operatorId") int operatorId) {
        return Result.success(userService.getUser(operatorId));
    }

    /**
     * 删除用户信息
     *
     * @param operatorId 操作员编号
     */
    @DeleteMapping("/delete/{operatorId}")
    public Result<?> deleteUser(@PathVariable("operatorId") int operatorId) {
        userService.deleteUser(operatorId);
        return Result.success();
    }

    /**
     * 分页查询所有用户
     *
     * @param page     页记录数
     * @param limit    页码
     * @param status   用户状态
     * @param userName 用户名
     * @param field    排序字段
     * @param order    排序方式
     * @return 用户列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/query")
    public Result<?> queryUsers(String page, String limit,
                                String userId, String userName,
                                String roleNameList, String userType,
                                String status, String userCreator,
                                String userUpdater,
                                String order, String field) {
        List users = userService.queryUsers(page, limit, userId, userName, roleNameList, userType, status, userCreator, userUpdater, order, field);
        return Result.success(users, userService.count(userId, userName, roleNameList, userType, status, userCreator, userUpdater));
    }

//	/**
// 	* 根据用户编码查询密码
//	* @param
// 	* @return
//	*/
//	public Result<?>queryPassword(String page, String limit, String userId,String order, String field){
//		List users = userService.queryPassword(page,limit,userId,order,field);
//		return Result.success(users,userService.countPa(userId));
//	}

    /**
     * 批量删除用户信息
     *
     * @param operatorIds 用户操作编号数组
     */
    @DeleteMapping("/batchDelete")
    public Result<?> deleteUsers(@RequestBody Integer[] operatorIds) {
        ArrayList<String> userIdArrayList = new ArrayList<String>();
        for (int operatorId : operatorIds) {
            //通过操作员id（用户主键）查询出PARTY_ID，即user_id 登录名
            String userId = userService.getUser(operatorId).getUserId();
            userIdArrayList.add(userId);
        }
        for (String userId : userIdArrayList) {
            //删除用户权限分配记录
            userService.deleteUsersAuth(userId);
        }
        //删除用户信息
        userService.deleteUsers(Arrays.asList(operatorIds));
        return Result.success();

    }

    /**
     * 通过用户登录名查询到用户的角色类型
     *
     * @param userId 用户操作编号数组
     */
    @GetMapping("/getRoleName")
    public Result<?> getRoleName(@RequestParam("userId") String userId){
        Map<String,Object> maps = new HashMap<>();
        List<UserPartyAuthVo> RoleNameList = userService.getRoleName(userId);//查询出数据
        maps.put("data",RoleNameList);
        return Result.success(RoleNameList);
    }



//	/**
//	 * 重置密码
//	 *
//	 * @param userIds 用户编号
//	 * @param
//	 */
//	@PostMapping("/user/updatePasswords")
//	@ResponseBody
//	public Result<?> updatePasswords(@RequestBody String[] userIds) {
//		/*调用重置密码*/
//		userService.updatePasswords(Arrays.asList(userIds));
//		return Result.success();
//
//	}

    /**
     * 重置密码
     *
     * @param users 用户编号
     * @param
     */
    @PostMapping("/updatePasswords")
    @ResponseBody
    public Result<?> updatePasswords(@RequestBody List<User> users) {
        /*调用重置密码*/
        userService.updatePasswords(users);
        return Result.success();

    }


    /**
     * 检测用户是否存在
     *
     * @param userId 用户名字
     */
    @GetMapping("/check/isExist")
    public Result<?> checkUser(@RequestParam("userId") String userId) {
        if (userService.checkUser(userId) > 0) {
            return Result.error("1", "用户以存在");
        } else {
            return Result.success();
        }

    }

//
//
//    /**
//     * 模板查询用户信息
//     *
//     * @param template 查询用户
//     * @return user 用户详细
//     */
//    @GetMapping("/getCapUser")
//    public Result<?> getCapUser(@RequestBody User template) {
//        return Result.success();
//    }
//

//
//
//    /**
//     * 注册用户
//     *
//     * @param user 用户
//     */
//    @PostMapping("/registerUser")
//    public void registerUser(@RequestBody User user) {
//
//    }
//

//    /**
//     * 更新密码
//     *
//     * @param user     用户
//     * @param password 密码
//     * @return 状态码
//     */
//    @RequestMapping("/updatePassword/{password}")
//    public Result<?> updatePassword(@RequestBody User user, @PathVariable("password") String password) {
//        return Result.success();
//    }
//
//    /**
//     * 更改多个密码
//     *
//     * @param users 用户集合
//     */
//    @PostMapping("/updatePasswords")
//    public void updatePasswords(@RequestParam(value = "users") List<User> users) {
//
//    }
//
//
}
