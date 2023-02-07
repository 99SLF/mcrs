package com.zimax.components.coframe.auth.service;

import com.zimax.cap.access.http.OnlineUserManager;
import com.zimax.cap.auth.IAuthManagerService;
import com.zimax.cap.auth.MenuTree.MenuTreeNode;
import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.cap.party.impl.UserObject;
import com.zimax.components.coframe.auth.DefaultAuthManagerService;
import com.zimax.components.coframe.init.UserObjectInit;
import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.components.coframe.rights.service.UserService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * 登录验证
 *
 * @author 施林丰
 * @date 2022/11/29
 */
@Service
public class LoginService {

    @Autowired
    UserService userService;

    /**
     * 根据用户对象登录
     *
     * @param userObject 用户对象
     */
    public void login(UserObject userObject) {
        OnlineUserManager.login(userObject);
    }

    /**
     * 登录验证
     *
     * @param userId   用户账号
     * @param password 密码
     */
    public Result authentication(String userId, String password) {
        User user = userService.getUserByUserId(userId);
        if (user == null) {
            return Result.error("1", "用户不存在");
        }
        Result result = isEnd(user);
        if (result.getCode() == "1") {
            return Result.error("1", result.getMsg());
        }
        if (!"102".equals(user.getStatus())) {
            return Result.error("1", "用户无权限登录，请联系系统管理员！");
        }
        if (user.getPassword().equals(userService.encodePassword(password))) {
            return Result.success();
        } else {
            return Result.error("1", "密码错误");
        }
    }

    /**
     * 验证用户是否失效
     */
    public Result<?> isEnd(User user) {
        Date today = new Date();
        if (user.getEndDate() == null) {
            if (user.getStartDate() == null) {
                if (user.getInvalDate() != null) {
                    if (today.compareTo(user.getInvalDate()) >= 0) {
                        return Result.error("1", "密码过期");
                    } else {
                        return Result.error("0", "");
                    }
                } else {
                    return Result.success();
                }
            } else {
                if (today.compareTo(user.getStartDate()) <= 0) {
                    return Result.error("1", "用户未到开始使用时间！");
                } else {
                    if (user.getInvalDate() != null) {
                        if (today.compareTo(user.getInvalDate()) >= 0) {
                            return Result.error("1", "密码过期");
                        } else {
                            return Result.error("0", "");
                        }
                    } else {
                        return Result.success();
                    }
                }
            }
        } else {
            if (today.compareTo(user.getEndDate()) >= 0) {
                return Result.error("1", "用户已过期！");
            } else {
                if (today.compareTo(user.getStartDate()) <= 0) {
                    return Result.error("1", "用户未到开始使用时间！");
                } else {
                    if (user.getInvalDate() != null) {
                        if (today.compareTo(user.getInvalDate()) >= 0) {
                            return Result.error("1", "密码过期");
                        } else {
                            return Result.error("0", "");
                        }
                    } else {
                        return Result.success();
                    }
                }
            }
        }
    }

    /**
     * 注销用户
     */
    public void logout() {
        Object rootObject = DataContextManager.current().getSessionCtx().getRootObject();
        IUserObject userObject = null;
        if ((rootObject instanceof HttpSession)) {
            userObject = (IUserObject) ((HttpSession) rootObject).getAttribute("userObject");
        }
        if (userObject != null) {
            OnlineUserManager.logoutByUniqueId(userObject.getUniqueId());
        }
    }

    /**
     * 获取当前应用首页菜单数据
     *
     * @param appCode 应用编号
     * @return 菜单数据
     */
    public List<MenuTreeNode> getUserMenuTreeByAppCode(String appCode) {
        IAuthManagerService service = new DefaultAuthManagerService();
        return service.getUserMenuTreeByAppCode(appCode)
                .getMenuTreeRootNodeList();
    }

    /**
     * 初始化用户对象
     *
     * @param userId 用户编号
     * @return 用户对象
     */
    public UserObject initUserObject(String userId) {
        return UserObjectInit.INSTANCE.init(userId);
    }

}
