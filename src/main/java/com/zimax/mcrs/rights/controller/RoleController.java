package com.zimax.mcrs.rights.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.rights.pojo.Role;
import com.zimax.mcrs.rights.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 角色管理
 * @author 施林丰
 * @date 2022/11/28
 */
@RestController
@ResponseBody
@RequestMapping("/role")
public class RoleController {

    //角色服务
    @Autowired
    private RoleService roleService;

    @RequestMapping("/test")
    public String test() {
        roleService.queryRoles(1,2);
        return "hello";
    }

   /* @RequestMapping("/add")
    public Result<?> addRole(@RequestBody Role role) {
        roleService.addRole(role);
        return Result.success();
    }

    *//**
     * 更新角色
     * @param role 角色信息
     *//*
    @PutMapping("/update")
    public  Result<?>  updateRole(@RequestBody Role role) {
        roleService.updateRole(role);
        return Result.success();
    }

    *//**
     * 获取角色
     * @param roleId 角色编号
     * @return 角色信息
     *//*
    @GetMapping("/find/{roleId}")
    public Result<?>  getRole(@PathVariable("roleId") int roleId) {
        return Result.success(roleService.query(roleId));
    }

    *//**
     * 删除角色
     * @param roleId 角色编号
     *//*
    @DeleteMapping("/delete/{roleId}")
    public  Result<?>  removeRole(@PathVariable("roleId")int roleId) {
        roleService.deleteById(roleId);
        return Result.success();
    }

    *//**
     * 查询角色
     * @param roleCode 角色代码
     * @param roleName 角色名字
     * @param limit 记录数
     * @param page 页码
     * @return 角色列表
     *//*
    @GetMapping("/query")
    public Result<?> queryRoles(String roleCode, String roleName, int limit, int page) {
       return Result.success(roleService.queryAll());
    }
*/
}
