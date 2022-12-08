package com.zimax.components.coframe.framework.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zimax.components.coframe.framework.pojo.Function;
import com.zimax.components.coframe.framework.pojo.Menu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Map;

/**
 * @Author 李伟杰
 * @Date: 2022/11/29/ 20:45
 * @Description
 */
@Mapper
public interface MenuMapper {

    /**
     * 查询所有菜单
     * @param map 菜单集合
     * @return
     */
    List<Menu> queryMenus(Map map);

    /**
     * 获取单挑菜单数据
     * @param menuId 菜单编号
     * @return
     */
    Menu getMenu(String menuId);

    /**
     * 新增菜单
     * @param menu 菜单
     * @return
     */
    void addMenu(Menu menu);

    /**
     * 删除菜单
     * @param menuId 菜单编码
     * @return
     */
    void deleteMenu(String menuId);

    /**
     * 批量删除菜单
     * @param menuIds 菜单编号列表
     * @return
     */
    void deleteMenus(List<String> menuIds);

    /**
     * 更新菜单
     * @param menu 菜单
     * @return
     */
    void updateMenu(Menu menu);

    /**
     * 查询记录数
     * @param menuId 菜单编码
     * @return
     */
    int count(@Param("menuId") String menuId);


//    /**
//     *删除菜单
//     */
//    public void deleteMenu(String menuId);
//
//    /**
//     *获取菜单
//     */
//    public Menu getMenu();
//
//    /**
//     *查询菜单功能
//     */
//    public List<Function> queryFunction(String funcCode, String funcName);
//
//    /**
//     *分页查询菜单列表
//     */
//    public List<Function> queryMenu(String funcCode, String funcName);
//
//    /**
//     *分页查询菜单列表
//     */
//    public String queryMenuFuncResource(String funcCode);
//
//    /**
//     *分页查询菜单列表
//     */
//    public List<Menu> queryMenuList(String parentMenuId, String menuName);
//
//    /**
//     *查询菜单树
//     */
//    public List<Menu> queryMenuTreeNode(String nodeId);
//
//    /**
//     *更新菜单
//     */
//    public void saveMenu(Menu menu);
//
//    /**
//     *修改菜单
//     */
//    public void updateMenu(Menu menu);
//
//    /**
//     *修改菜单关系
//     */
//    public void updateMenuRelation(String nodeId, String nodeType, String targetNodeId, String targetNodeType);


}
