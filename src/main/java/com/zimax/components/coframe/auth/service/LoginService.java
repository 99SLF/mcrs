package com.zimax.components.coframe.auth.service;

import com.zimax.cap.access.http.OnlineUserManager;
import com.zimax.cap.auth.IAuthManagerService;
import com.zimax.cap.auth.MenuTree.MenuTreeNode;
import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.cap.party.impl.UserObject;
import com.zimax.components.coframe.auth.DefaultAuthManagerService;
import com.zimax.components.coframe.init.UserObjectInit;
import com.zimax.mcrs.config.Result;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 登录验证
 * @author 施林丰
 * @date 2022/11/29
 */
@Service
public class LoginService {

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
     * @param userId 用户账号
     * @param password 密码
     */
    public Result<?> authentication(String userId, String password) {

        Result<String> result = new Result<>();
        result.setCode("0");
        return result;
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
