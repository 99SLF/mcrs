package com.zimax.components.coframe.framework.service;

import com.zimax.components.coframe.framework.mapper.MenuMapper;
import com.zimax.components.coframe.framework.pojo.Menu;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * @Author 李伟杰
 * @Date: 2022/11/29/ 19:28
 * @Description
 */
public class MenuService {
    @Autowired
    private MenuMapper MenuMapper;

    public List<Menu> queryMenu() {
        return MenuMapper.selectList(null);
    }
}
