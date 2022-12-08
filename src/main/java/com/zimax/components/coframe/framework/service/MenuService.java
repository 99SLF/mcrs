package com.zimax.components.coframe.framework.service;

import com.zimax.components.coframe.framework.IMenuService;
import com.zimax.components.coframe.framework.mapper.MenuMapper;
import com.zimax.components.coframe.framework.pojo.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author 李伟杰
 * @Date: 2022/11/29/ 19:28
 * @Description
 */
public class MenuService implements IMenuService {

    @Autowired
    private MenuMapper menuMapper;

    @Override
    public Menu[] queryMenus() {
        List<Menu> menuList = menuMapper.queryMenus();
        return menuList.toArray(new Menu[menuList.size()]);
    }

    public MenuMapper getMenuMapper() {
        return menuMapper;
    }

    public void setMenuMapper(MenuMapper menuMapper) {
        this.menuMapper = menuMapper;
    }

}
