package com.zimax.mcrs.basic.aboutEmployee.controller;


import com.zimax.mcrs.basic.aboutEmployee.pojo.Emp;
import com.zimax.mcrs.basic.aboutEmployee.pojo.EmpVo;
import com.zimax.mcrs.basic.aboutEmployee.pojo.EmployeeRole;
import com.zimax.mcrs.basic.aboutEmployee.service.EmpService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@ResponseBody
@RequestMapping("/EmpController")
public class EmpController {
    @Autowired
    private EmpService empService;


    /**
     * 分页条件查询员工信息
     * @param page 页码
     * @param limit 条数
     * @param jobNo 工号
     * @param order 排序方式
     * @param field 排序字段
     * @return
     */
    @GetMapping("/query")
    public Result<?> queryEmps(String page, String limit, String jobNo, String order, String field) {
        List<EmpVo> emps = empService.queryEmp(page, limit, jobNo, order,field);
        return Result.success(emps,empService.count());
    }

    /**
     * 添加一条员工信息
     * @param emp 员工
     * @return
     */
    @PostMapping("/add")
    public Result<?> addEmp(@RequestBody Emp emp) {
        empService.addEmp(emp);
        return Result.success();
    }

    /**
     * 修改员工信息
     * @param emp 员工对象
     * @return
     */
    @PostMapping("/update")
    public Result<?> updateEmp(@RequestBody Emp emp) {
        empService.updateEmp(emp);
        return Result.success();
    }

    /**
     * 在添加员工时判断员工工号是否已存在
     * @param jobNo 员工工号
     * @return
     */
    @GetMapping("/isExist")
    public Result<?> check(@RequestParam("jobNo") String jobNo) {
        if(empService.checkJobNo(jobNo)>0){
            return Result.error("1","当前员工工号已存在，请输入正确的角色代码");
        }else {
            return Result.success();
        }
    }

    /**
     * 删除一条员工信息
     * @param jobId 员工主键
     * @return
     */
    @DeleteMapping("/delete")
    public Result<?> deleteEmp(@RequestParam("jobId") int jobId){
        empService.deleteEmp(jobId);
        return Result.success();
    }

    /**
     * 批量删除
     * @param jobIds
     * @return
     */
    @DeleteMapping("/batchDelete")
    public Result<?> batchDeleteEmp(@RequestBody Integer[] jobIds){
        empService.batchDeleteEmp(jobIds);
        return Result.success();
    }


    /**
     * 查询已授权的员工角色
     * @param jobId 员工主键
     * @return
     */
    @GetMapping("/queryAuthorizedRoles")
    public Result<?> queryAuthorizedRoles(@RequestParam("jobId") int jobId){
        return Result.success(empService.queryAuthorizedRoles(jobId));
    }

    /**
     * 查询未授权的员工角色
     * @param jobId 员工主键
     * @return
     */
    @GetMapping("/queryUnauthorizedRoles")
    public Result<?> queryUnauthorizedRoles(@RequestParam("jobId") int jobId){
        return Result.success(empService.queryUnauthorizedRoles(jobId));
    }

    /**
     * 批量删除授权的员工角色
     * @param jobId 员工id
     * @param roleList 已授权的角色集合
     * @return
     */
    @PostMapping("/deleteRoles/{jobId}")
    public Result<?> deleteRoles(@PathVariable("jobId") int jobId, @RequestBody List<EmployeeRole> roleList){
        return Result.success(empService.deleteRoles(jobId,roleList));
    }

    /**
     * 批量授权员工角色
     * @param jobId 员工id
     * @param roleList 选中的角色集合
     * @return
     */
    @PostMapping("/addRoles/{jobId}")
    public Result<?> addRoles(@PathVariable("jobId") int jobId, @RequestBody List<EmployeeRole> roleList){
        return Result.success(empService.addRoles(jobId,roleList));
    }

    /**
     * 通过设备资源号查询员工实体集合
     * @param resource 设备资源号
     * @return
     */
    @GetMapping("/getEmpListByResource")
    public Result<?> getEmpListByResourceId(@RequestParam("resource") String resource){
        String equipmentId = resource;
        return Result.success(empService.getEmpListByResourceId(equipmentId));
    }
}








