package com.zimax.components.coframe.framework.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.components.coframe.framework.pojo.Menu;
import com.zimax.components.coframe.framework.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author 李伟杰
 * @Date: 2022/11/29/ 19:26
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/menu")
public class MenuController {
    //菜单服务
    @Autowired
    private MenuService menuService;



//    /**
//     * deleteMenus(DataObject[])
//     */
//

    /**
     * 修改菜单
     * @param menu 菜单
     */
    @PutMapping("/updateMenu")
    public Result<?> updateMenu(@RequestBody Menu menu){
        return Result.success();
    }

//    /**
//     * 更新菜单
//     * @param menu 菜单
//     */
//    @PutMapping("/saveMenu")
//    public void saveMenu(@RequestBody Menu menu){
//
//    }

    /**
     * 修改菜单关系
     * @param nodeId 节点编号
     * @param nodeType 节点类型
     * @param targetNodeId 目标节点编号
     * @param targetNodeType 目标节点类型
     * @return
     */
    @RequestMapping("/updateMenuRelation")
    public void updateMenuRelation(@PathVariable("nodeId") String nodeId , @PathVariable("nodeType") String nodeType ,
                                   @PathVariable("targetNodeId") String targetNodeId , @PathVariable("targetNodeType") String targetNodeType)
    {

    }

    /**
     * 分页查询菜单列表
     */
    @GetMapping("/queryMenu")
    public  Result<?> queryMenu(String parentMenuId , String menuName , int page , int limit){
        List<Menu> menus = menuService.queryMenu();
        return Result.success();
    }

    /**
     * 获取菜单
     * @param menuId 菜单编号
     * @return 菜单信息
     */
    @GetMapping("/find/{menuId}")
    public Result<?> getMenu(@PathVariable("menuId") String menuId) {
        return Result.success(null);
    }

    /**
     * 删除菜单
     * @param menuId 菜单编号
     */
    @DeleteMapping("/delete/{menuId}")
    public Result<?> removeUsers(@PathVariable("menuId")String menuId) {
        return Result.success();
    }

    /**
     * 删除菜单节点
     * @param Menus 菜单节点列表
     */
    @RequestMapping(value = "/removeMenus",method = RequestMethod.POST)
    public List<Menu> removeMenus(@RequestBody List<Menu> Menus){

        return Menus;
    }



//     /**
//     * 查询菜单，需先查询出功能编码 funcCode和功能名 funcName
//     * @param limit 页记录数
//     * @param page 页码
//     * @param funcCode 功能编码
//     * @param funcName 功能名
//     * @return function 功能详细信息
//     * @return 总记录数
//     *
//     */
//
//    @GetMapping("/queryFunctionAll")
//    public Result<?>queryFunction(String funcCode , String funcName, int limit, int page) {
//
//        List<Function> all = functionService.queryFunction();
//        return Result.success();
//    }

     /**
     * 分页查询菜单列表list
     */
     @GetMapping("/queryMenuList")
     public  Result<?> queryMenuList(String parentMenuId , String menuName ){
         List<Menu> menus = menuService.queryMenu();
         return Result.success();
     }

     /**
      *查找菜单功能资源名字
      */

    /**
     * validateMenu验证菜单
     */
}
