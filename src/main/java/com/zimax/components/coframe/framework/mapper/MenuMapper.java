package com.zimax.components.coframe.framework.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zimax.components.coframe.framework.pojo.Function;
import com.zimax.components.coframe.framework.pojo.Menu;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

/**
 * @Author 李伟杰
 * @Date: 2022/11/29/ 20:45
 * @Description
 */
@Mapper
public interface MenuMapper {

    /**
     *删除菜单
     */
    public void deleteMenu(String menuId);

    /**
     *获取菜单
     */
    public Menu getMenu();

    /**
     *查询菜单功能
     */
    public List<Function> queryFunction(String funcCode, String funcName);

    /**
     *分页查询菜单列表
     */
    public List<Function> queryMenu(String funcCode, String funcName);

    /**
     *分页查询菜单列表
     */
    List<Menu> queryMenus();

    /**
     *分页查询菜单列表
     */
    public String queryMenuFuncResource(String funcCode);

    /**
     *分页查询菜单列表
     */
    public List<Menu> queryMenuList(String parentMenuId, String menuName);

    /**
     *查询菜单树
     */
    public List<Menu> queryMenuTreeNode(String nodeId);

    /**
     *更新菜单
     */
    public void saveMenu(Menu menu);

    /**
     *修改菜单
     */
    public void updateMenu(Menu menu);

    /**
     *修改菜单关系
     */
    public void updateMenuRelation(String nodeId, String nodeType, String targetNodeId, String targetNodeType);


}
