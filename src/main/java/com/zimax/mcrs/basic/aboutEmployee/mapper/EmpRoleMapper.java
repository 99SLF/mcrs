package com.zimax.mcrs.basic.aboutEmployee.mapper;

import com.zimax.mcrs.basic.aboutEmployee.pojo.EmployeeRole;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface EmpRoleMapper {
    /**
     * 删除角色的资源授权
     * @param roleId
     */
    void deleteResources(@Param("roleId") int roleId);

    /**
     * 添加资源授权
     * @param roleId 角色id
     * @param equId 设备id
     * @return
     */
    int addResource(@Param("roleId") int roleId, @Param("equId") int equId);

    /**
     * 查询是否已存在此条数据
     * @param roleId 角色id
     * @param equId 设备id
     * @return
     */
    int getCheckedState(@Param("roleId") int roleId, @Param("equId") int equId);

    /**
     * 分页条件查询角色
     * @param map 查询条件
     * @return
     */
    List<EmployeeRole> queryRole(Map map);

    /**
     * 查询角色表总记录数
     * @return
     */
    int count();

    /**
     * 添加一条角色记录
     * @param employeeRole 角色对象
     * @return
     */
    void add(EmployeeRole employeeRole);

    /**
     * 删除一条角色记录
     * @param roleId 角色主键
     * @return
     */
    void delete(int roleId);

    /**
     * 修改角色信息
     * @param employeeRole
     * @return
     */
    void update(EmployeeRole employeeRole);

    /**
     * 角色代码的唯一性校验
     * @param roleCode
     * @return
     */
    int checkRoleCode(String roleCode);
}
