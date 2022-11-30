package com.zimax.mcrs.framework.service;

import com.zimax.mcrs.framework.mapper.MenuMapper;
import com.zimax.mcrs.framework.pojo.Menu;
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
