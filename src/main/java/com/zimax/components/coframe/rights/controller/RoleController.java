package com.zimax.components.coframe.rights.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.components.coframe.rights.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 角色管理
 * @author 施林丰
 * @date 2022/11/28
 */
@RestController
@RequestMapping("/role")
public class RoleController {

    //角色服务
    @Autowired(required = false)
    private RoleService roleService;
    @GetMapping("/test")
    public Result<?> test() {
        return Result.success(roleService.queryRoles());
    }

    @RequestMapping("/add")
    public Result<?> addRole(@RequestBody Role role) {
        //roleService.addRole(role);
        return Result.success();
    }

    /**
     * 更新角色
     * @param role 角色信息
     */
    @PutMapping("/update")
    public Result<?> updateRole(@RequestBody Role role) {
        //roleService.updateRole(role);
        return Result.success();
    }

    /**
     * 获取角色
     * @param roleId 角色编号
     * @return 角色信息
     */
    @RequestMapping("/find/{roleId}")
    public Result<?> getRole(@PathVariable("roleId") int roleId) {
        return Result.success();
    }

    /**
     * 删除角色
     * @param roleId 角色编号
     */
    @DeleteMapping("/delete/{roleId}")
    public Result<?> removeRole(@PathVariable("roleId")int roleId) {
        //roleService.deleteById(roleId);
        return Result.success();
    }

    /**
     * 查询角色
     * @param roleCode 角色代码
     * @param roleName 角色名字
     * @param limit 记录数
     * @param page 页码
     * @return 角色列表
     */
    @GetMapping("/query")
    public Result<?> queryRoles(@RequestParam String roleCode, @RequestParam String roleName, @RequestParam int limit, @RequestParam int page) {
       return Result.success();
    }
}
