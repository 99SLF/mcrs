package com.zimax.mcrs.basic.aboutEmployee.mapper;

import com.zimax.mcrs.basic.aboutEmployee.pojo.Emp;
import com.zimax.mcrs.basic.aboutEmployee.pojo.EmpVo;
import com.zimax.mcrs.basic.aboutEmployee.pojo.EmployeeRole;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface EmpMapper {

    /**
     * 通过设备资源号查询员工实体集合
     * @param equipmentId 设备资源号
     * @return
     */
    List<EmpVo> getEmpListByResourceId(@Param("equipmentId") String equipmentId);

    /**
     * 分页查询员工信息
     * @param map
     * @return
     */
    List<EmpVo> queryEmp(Map map);

    /**
     * 添加一条员工信息
     * @param emp 员工
     * @return
     */
    void addEmp(Emp emp);

    /**
     * 查询表中的总记录数
     * @return
     */
    int count();

    /**
     * 在添加员工时判断员工工号是否已存在
     * @param jobNo 员工工号
     * @return
     */
    int checkJobNo(String jobNo);

    /**
     * 修改员工信息
     * @param emp 员工对象
     * @return
     */
    void updateEmp(Emp emp);

    /**
     * 删除一条员工信息
     * @param jobId 员工主键
     * @return
     */
    void deleteEmp(int jobId);

    /**
     * 批量删除
     * @param jobIds
     */
    void batchDeleteEmp(Integer[] jobIds);

    /**
     * 查询已授权的角色
     * @param jobId
     * @return
     */
    List<EmployeeRole> queryAuthorizedRoles(int jobId);

    /**
     * 查询所有角色
     * @return
     */
    List<EmployeeRole> queryAllRoles();

    /**
     * 批量删除授权的员工角色
     */
    boolean deleteRoles( List<EmpVo> list);

    boolean addRoles( List<EmpVo> list);
}
