package com.zimax.mcrs.basic.aboutEmployee.controller;


import com.zimax.mcrs.basic.aboutEmployee.pojo.EmployeeRole;
import com.zimax.mcrs.basic.aboutEmployee.service.EmpRoleService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/EmpRoleController")
public class EmpRoleController {
    @Autowired
    private EmpRoleService empRoleService;



    /**
     * 添加一条角色记录
     * @param employeeRole 角色对象
     * @return
     */
    @PostMapping("/add")
    public Result<?> addRole(@RequestBody EmployeeRole employeeRole){
        empRoleService.add(employeeRole);
        return  Result.success();
    }

    /**
     * 删除一条角色记录
     * @param roleId 角色主键
     * @return
     */
    @DeleteMapping("/delete")
    public Result<?> deleteRole(@RequestParam("roleId") int roleId){
        empRoleService.delete(roleId);
        return Result.success();
    }

    /**
     * 修改角色信息
     * @param employeeRole
     * @return
     */
    @PostMapping("/update")
    public Result<?> update(@RequestBody EmployeeRole employeeRole){
        empRoleService.update(employeeRole);
        return Result.success();
    }

    /**
     * 分页条件查询角色信息
     * @param page 页码
     * @param limit 条数
     * @param roleCode 角色代码
     * @param roleName 角色名字
     * @param order 排序方式
     * @param field 排序字段
     * @return
     */
    @GetMapping("/query")
    public Result<?> queryRole(String page, String limit, String roleCode, String roleName, String order, String field){
        List<EmployeeRole> employeeRoles = empRoleService.queryRole(page, limit, roleCode, roleName,order,field);
        return Result.success(employeeRoles,empRoleService.count());
    }

    /**
     * 角色代码的唯一性校验
     * @param roleCode
     * @return
     */
    @GetMapping("/isExist")
    public Result<?> checkRoleCode(@RequestParam("roleCode") String  roleCode){
        if (empRoleService.checkRoleCode(roleCode)>0){
            return Result.error("1","当前角色代码已存在，请输入正确的角色代码");
        }else {
            return Result.success();
        }
    }
}
