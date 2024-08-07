package com.zimax.components.coframe.framework.service;

import com.zimax.components.coframe.framework.IMenuService;
import com.zimax.components.coframe.framework.mapper.MenuMapper;
import com.zimax.components.coframe.framework.pojo.Menu;
import com.zimax.mcrs.config.ChangeString;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 李伟杰
 * @Date: 2022/11/29/ 19:28
 * @Description
 */
public class MenuService implements IMenuService {

    private MenuMapper menuMapper;

    public MenuMapper getMenuMapper() {
        return menuMapper;
    }

    public void setMenuMapper(MenuMapper menuMapper) {
        this.menuMapper = menuMapper;
    }

    @Override
    public Menu[] queryMenus() {
        Map<String, Object> map = new HashMap<>();
        map.put("field", "display_order");
        map.put("order", "asc");
        List<Menu> menuList = menuMapper.queryMenus(map);
        return menuList.toArray(new Menu[menuList.size()]);
    }

    /**
     * 查询所有菜单信息
     * @param page 页码
     * @param limit 记录数
     * @param order 排序方式
     * @param field 排序字段
     * @return
     */
    public List<Menu> queryMenus(String  page, String limit, String parentMenuId , String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","asc");
            map.put("field","display_order");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if(limit!=null){
            map.put("begin",Integer.parseInt(limit)*(Integer.parseInt(page)-1));
            map.put("limit",Integer.parseInt(limit));
        }
        map.put("parentMenuId",parentMenuId);
        return menuMapper.queryMenuList(map);
    }


    /**
     * 添加菜单信息
     * @param menu 菜单
     */
    public void addMenu(Menu menu) {
        String primaryKey = menuMapper.getPrimaryKey();
        menu.setMenuId(primaryKey);
        String parentMenuId = menu.getParentMenuId();
        if("root".equals(parentMenuId) || "null".equals(parentMenuId) || parentMenuId==null||"".equals(parentMenuId)){
            menu.setMenuLevel(1);
            menu.setMenuSeq("."+primaryKey+".");
            menu.setSubCount(0);
            menuMapper.addMenu(menu);
        }else{
            Menu menu1 = menuMapper.getMenu(menu.getParentMenuId());
            menu.setMenuLevel(menu1.getMenuLevel()+1);
            menu.setMenuSeq(menu1.getMenuSeq()+primaryKey+".");
            menu.setSubCount(0);
            menuMapper.addMenu(menu);
            menu1.setSubCount(menu1.getSubCount()+1);
            menuMapper.updateMenu(menu1);
        }

    }

    /**
     * 根据菜单编号删除
     * @param menuId 菜单编号
     */
    public void deleteMenu(String menuId) {
        menuMapper.deleteMenu(menuId);
    }

    /**
     * 更新菜单
     * @param menu 菜单信息
     */
    public void updateMenu(Menu menu) {
        menuMapper.updateMenu(menu);
    }

    /**
     * 根据菜单编码查询
     * @param menuId 菜单编号
     */
    public Menu getMenu(String menuId) {
        return menuMapper.getMenu(menuId);
    }

    /**
     * 批量删除菜单
     * @param menuIds 菜单编号集合
     */
    public void deleteMenus(List<String> menuIds) {
        menuMapper.deleteMenus(menuIds);
    }

    /**
     * 查询记录
     */
    public int count(String appId){
        return menuMapper.count(appId);
    }

    /**
     * 查询记录
     */
    public int countMenu(String parentMenuId ){
        return menuMapper.countMenu(parentMenuId);
    }

    /**
     * 查看菜单编码是否已存在
     */
    public int getMenuByCode(String menuCode ){
        return menuMapper.getMenuByCode(menuCode);
    }
}