package com.zimax.components.coframe.auth.menu;

import com.zimax.cap.management.resource.IMenuResourceManager;

/**
 * 功能菜单资源管理
 *
 * @author 苏尚文
 * @date 2022/12/8 19:06
 */
public class FunctionMenuResourceManager implements IMenuResourceManager {

    public boolean canAccess(String[] states) {
        // 0代表无权限，1代表有权限
        for (String state : states) {
            if ("1".equals(state)) {
                return true;
            }
        }
        return false;
    }

    public String getResourceURI(String resourceID) {
        return null;
    }

}