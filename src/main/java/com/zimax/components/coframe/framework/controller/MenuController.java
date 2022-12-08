package com.zimax.components.coframe.framework.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.components.coframe.framework.pojo.Menu;
import com.zimax.components.coframe.framework.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * @Author 李伟杰
 * @Date: 2022/11/29/ 19:26
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/framework")
public class MenuController {

    //菜单服务
    @Autowired
    private MenuService menuService;

    /**
     * 新增菜单
     * @param menu 菜单信息
     */
    @PostMapping("/menu/add")
    public Result<?> addMenu(@RequestBody Menu menu) {
        menuService.addMenu(menu);
        return Result.success();
    }

    /**
     * 更新菜单
     * @param menu 菜单信息
     */
    @PostMapping("/menu/update")
    public Result<?> updateMenu(@RequestBody Menu menu) {
        menuService.updateMenu(menu);
        return Result.success();
    }

    /**
     * 删除菜单
     * @param menuId 菜单编号
     */
    @DeleteMapping("/menu/delete{menuId}")
    public Result<?> deleteMenu(@PathVariable int menuId) {
        menuService.deleteMenu(menuId);
        return Result.success();
    }

    /**
     * 批量删除菜单
     *
     * @param menuIds 用户操作编号数组
     */
    @DeleteMapping("/menu/batchDelete")
    public Result<?> deleteMenus (@RequestBody Integer[] menuIds) {
        menuService.deleteMenus(Arrays.asList(menuIds));
        return Result.success();
    }

    /**
     * 查询菜单
     * @return 菜单列表
     * @param menuId 菜单编号
     * @param limit 记录数
     * @param page 页码
     * @param field 排序字段
     * @param order 排序方式
     */
    @GetMapping("/menu/query")
    public Result<?> queryMenus(String page, String limit, String menuId, String order, String field) {
        List menuIds = menuService.queryMenus(page,limit,menuId,order,field);
        return Result.success(menuIds,menuService.count(menuId));
    }

    /**
     * 获取菜单信息
     * @param menuId 菜单编号
     * @return 菜单信息
     */
    @GetMapping("/menu/find/{menuId}")
    public Result<?>  getMenu(@PathVariable("menuId") int menuId) {
        return Result.success(menuService.getMenu(menuId));
    }



//    /**
//     * 删除菜单
//     * @param menuId 菜单编号
//     */
//    @DeleteMapping("/deleteMenu")
//    public void deleteMenu(@PathVariable("menuId") String menuId ){
//
//    }



//    /**
//     * 删除菜单节点
//     * @param nodeList 节点列表
//     */
//    @DeleteMapping("/deleteMenuNodes/{nodeList}")
//    private void deleteMenuNodes(@RequestParam(value = "nodeList") List<?> nodeList){
//
//    }


//    /**
//     * 删除菜单，多条
//     * @param nodes 节点列表
//     */
//    @DeleteMapping("/deleteMenus/{nodes}")
//    public void deleteMenus(@RequestParam(value = "nodes") List<?> nodes){
//
//    }




//    /**
//     * 获取菜单
//     * @param template 选中菜单
//     * @return menu 菜单信息
//     */
//    @GetMapping("/getMenu")
//    public Result<?> getMenu(@RequestBody Menu template){
//        return Result.success();
//
//    }

//    /**
//     * 查询菜单功能
//     * @param funcCode 功能编码
//     * @param funcName 功能名
//     * @return data Function数组
//     * @return total 总记录数
//     */
//    @GetMapping("/queryFunction")
//    public Result<?> queryFunction(@PathVariable("funcCode") String funcCode, @PathVariable("funcName") String funcName, @PathVariable("limit") int limit, @PathVariable("page") int page){
//        return Result.success();
//    }


//    /**
//     * 分页查询菜单列表
//     * @param parentMenuId 功能编码
//     * @param menuName 功能名
//     * @return data Function数组
//     * @return total 总记录数
//     * @return code 状态码
//     * @return msg 返回消息
//     */
//    @GetMapping("/queryMenu")
//    public Result<?> queryMenu(@PathVariable("parentMenuId") String parentMenuId, @PathVariable("menuName") String menuName,@PathVariable("limit") int limit, @PathVariable("page") int page){
//        return Result.success();
//    }

//    /**
//     * 查找菜单功能资源名字
//     * @param funcCode 功能编码
//     * @return funcName 功能名
//     */
//    @GetMapping("/queryMenuFuncResource/{funcCode}")
//    public String queryMenuFuncResource(@PathVariable("funcCode") String funcCode){
//        return "";
//
//    }
//
//    /**
//     * 分页查询菜单列表
//     * @param parentMenuId 父菜单编号
//     * @param menuName 菜单名
//     * @return menus 菜单列表数组
//     * @return total 总记录数
//     * @return code 状态码
//     * @return msg 返回消息
//     */
//    @GetMapping("/queryMenuFuncResource/{parentMenuId}/{menuName}")
//    public Result<?> queryMenuList(@PathVariable("parentMenuId") String parentMenuId, @PathVariable("menuName") String menuName){
//        return Result.success();
//    }

//    /**
//     * 查询菜单树
//     * @param nodeId 节点编号
//     * @return data 返回菜单树
//     */
//    @GetMapping("/queryMenuTreeNode")
//    public List<?> queryMenuTreeNode(@PathVariable("nodeId") String nodeId){
//        return null;
//
//    }

//    /**
//     * 更新菜单
//     * @param menu 菜单
//     */
//    @PutMapping("/saveMenu")
//    public void saveMenu(@RequestBody Menu menu){
//
//    }

//    /**
//     * 修改菜单
//     * @param menu 菜单
//     */
//    @PostMapping("/updateMenu")
//    public void updateMenu(@RequestBody Menu menu){
//
//    }

//    /**
//     * 修改菜单关系
//     * @param nodeId 节点编号
//     * @param nodeType 节点类型
//     * @param targetNodeId 目标节点编号
//     * @param targetNodeType 目标节点类型
//     * @return
//     */
//    @RequestMapping("/updateMenuRelation")
//    public void updateMenuRelation(@PathVariable("nodeId") String nodeId , @PathVariable("nodeType") String nodeType ,
//                                   @PathVariable("targetNodeId") String targetNodeId , @PathVariable("targetNodeType") String targetNodeType)
//    {
//
//    }

//    /**
//     *验证菜单
//     * @param template 菜单
//     * @return
//     */
//    @GetMapping("/validateMenu")
//    public int validateMenu(@RequestBody Menu template){
//        return 0;
}

