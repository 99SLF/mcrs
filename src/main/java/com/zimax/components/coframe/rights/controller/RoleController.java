package com.zimax.components.coframe.rights.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.components.coframe.rights.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 角色管理
 *
 * @author 施林丰
 * @date 2022/11/28
 */
@RestController
@RequestMapping("/rights")
public class RoleController {

    //角色服务
    @Autowired
    private RoleService roleService;

    /**
     * 添加角色
     *
     * @param role 角色信息
     */
    @PostMapping("/role/add")
    public Result<?> addRole(@RequestBody Role role) {
        if (roleService.addRole(role) == 0) {
            return Result.success();
        } else {
            return Result.error();
        }
    }

    /**
     * 更新角色
     *
     * @param role 角色信息
     */
    @PostMapping("/role/update")
    public Result<?> updateRole(@RequestBody Role role) {
        if (roleService.updateRole(role) == 0) {
            return Result.success();
        } else {
            return Result.error();
        }

    }

    /**
     * 获取角色
     *
     * @param roleId 角色编号
     * @return 角色信息
     */
    @GetMapping("/role/find/{roleId}")
    public Result<?> getRole(@PathVariable("roleId") int roleId) {
        return Result.success(roleService.getRole(roleId));
    }

    /**
     * 删除角色
     *
     * @param roleId 角色编号
     */
    @DeleteMapping("/role/delete/{roleId}")
    public Result<?> deleteRole(@PathVariable("roleId") int roleId) {
        if (roleService.deleteRole(roleId) == 0) {
            return Result.success();
        } else {
            return Result.error();
        }
    }

    /**
     * 查询角色
     *
     * @param roleCode 角色代码
     * @param roleName 角色名字
     * @param limit    记录数
     * @param page     页码
     * @param field    排序字段
     * @param order    排序方式
     * @return 角色列表
     */
    @GetMapping("/role/query")
    public Result<?> queryRoles(String page, String limit, String roleCode, String roleName, String order, String field) {
        List roles = roleService.queryRoles(page, limit, roleCode, roleName, order, field);
        return Result.success(roles, roleService.count(roleCode, roleName));
    }

    /**
     * 批量删除角色
     *
     * @param roleIds 角色代码数组
     */
    @DeleteMapping("/role/batchDelete")
    public Result<?> deleteRoles(@RequestBody Integer[] roleIds) {
        if (roleService.deleteRoles(Arrays.asList(roleIds)) == 0) {
            return Result.success();
        } else {
            return Result.error();
        }
    }
}
