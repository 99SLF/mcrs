package com.zimax.components.coframe.framework;

import com.zimax.components.coframe.framework.pojo.Menu;

import java.util.List;
import java.util.Map;

/**
 * 菜单服务接口
 *
 * @author 苏尚文
 * @date 2022/12/6 15:12
 */
public interface IMenuService {

    /**
     * 新增菜单
     *
     * @param Menu
     */
//    void addMenu(Menu Menu);

    /**
     * 删除菜单
     *
     * @param appMenus
     */
//    void deleteMenu(Menu[] Menus);

    /**
     * 根据模板查询菜单
     *
     * @param Menu
     */
//    void getMenu(Menu Menu);

    /**
     * 分页查询
     *
     * @param criteriaType
     * @param pageCond
     * @return
     */
//    Menu[] queryMenus(CriteriaType criteriaType, PageCond pageCond);

    /**
     * 根据查询条件查询菜单
     *
     * @return
     */
    Menu[] queryMenus();

    /**
     * 修改菜单
     *
     * @param Menu
     */
//    void updateMenu(Menu Menu);

    /**
     * 获取根菜单
     *
     * @param menus
     * @return
     */
//    List<Map> getMenuRoot(DataObject[] menus);

    /**
     * 获取菜单节点
     *
     * @param menus
     * @return
     */
//    List<Map> getMenuNode(DataObject[] menus);

    /**
     * 根据查询条件查询菜单记录数
     *
     * @param criteria
     * @return
     */
//    int countMenus(CriteriaType criteria);

    /**
     * 生成主键
     *
     * @param Menu
     */
//    void getPrimaryKey(Menu Menu);

    /**
     * 根据主键删除菜单
     *
     * @param id
     */
//    void deleteMenuById(String id);

    /**
     * 修改菜单父子关系，拖拽时使用
     *
     * @param menuId
     * @param targetMenuId
     */
//    void modifyMenuRelation(String menuId, String targetMenuId);

    /**
     * 验证是否存在，0不存在，1存在
     *
     * @param Menu
     * @return
     */
//    int validateMenu(Menu Menu);
}
