package com.zimax.mcrs.basic.aboutEmployee.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.basic.aboutEmployee.mapper.EmpMapper;
import com.zimax.mcrs.basic.aboutEmployee.pojo.Emp;
import com.zimax.mcrs.basic.aboutEmployee.pojo.EmpVo;
import com.zimax.mcrs.basic.aboutEmployee.pojo.EmployeeRole;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.version.pojo.SelectResVersion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class EmpService {
    @Autowired
    private EmpMapper empMapper;

    /**
     * 分页条件查询所有员工
     * @param page 页码
     * @param limit 条数
     * @param jobNo 工号
     * @param order 排序字段
     * @return 员工集合
     */
    public List<EmpVo> queryEmp(String page, String limit, String jobNo, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("jobNo", jobNo);
        return empMapper.queryEmp(map);
    }

    /**
     * 添加一条员工信息
     * @param emp 员工数据模型
     * @return
     */
    public void addEmp(Emp emp){
        try {
            String creator = DataContextManager.current().getMUODataContext().getUserObject().getUserId();
            emp.setCreator(creator);
            System.out.println(creator);
            Date date = new Date();
            emp.setCreateTime(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        empMapper.addEmp(emp);
    }
    public int count(){
        return empMapper.count();
    }


    /**
     * 在添加员工时判断员工工号是否已存在
     * @param jobNo 员工工号
     * @return
     */
    public int checkJobNo(String jobNo) {
        return empMapper.checkJobNo(jobNo);
    }

    /**
     * 修改员工信息
     * @param emp 员工对象
     * @return
     */
    public void updateEmp(Emp emp){
        empMapper.updateEmp(emp);
    }

    /**
     * 删除一条员工信息
     * @param jobId 员工主键
     * @return
     */
    public void deleteEmp(int jobId){
        empMapper.deleteEmp(jobId);
    }


    /**
     * 批量删除
     * @param jobIds
     */
    public void batchDeleteEmp(Integer[] jobIds){
        empMapper.batchDeleteEmp(jobIds);
    }

    /**
     * 查询已授权的角色
     * @param jobId
     * @return
     */

    public List<EmployeeRole> queryAuthorizedRoles(int jobId){
        return empMapper.queryAuthorizedRoles(jobId);
    }

    /**
     * 查询未授权的角色
     * @param jobId
     * @return
     */
    public  List<EmployeeRole> queryUnauthorizedRoles(int jobId){
        List<EmployeeRole> authorizedRoles = empMapper.queryAuthorizedRoles(jobId);
        List<EmployeeRole> allRoles = empMapper.queryAllRoles();
        List<EmployeeRole> unauthorizedRoles = new ArrayList<>();
        for (EmployeeRole role : allRoles) {
            boolean checked = false;
            if (authorizedRoles!=null){
                for (EmployeeRole authorizedRole : authorizedRoles) {
                    if (authorizedRole.getRoleId()==role.getRoleId()){
                        checked = true;
                    }
                }
            }
            if (!checked){
                unauthorizedRoles.add(role);
            }
        }
        return unauthorizedRoles;
    }

    /**
     * 删除选中的角色信息
     * @param jobId
     * @return
     */
    public boolean deleteRoles(int jobId, List<EmployeeRole> roleList){
        List<EmpVo> list = new ArrayList<>();
        for (EmployeeRole role : roleList) {
            EmpVo emp = new EmpVo();
            emp.setJobId(jobId);
            emp.setRoleId(role.getRoleId());
            list.add(emp);
        }
        return empMapper.deleteRoles(list);
    }

    /**
     * 给员工添加角色信息
     * @param jobId
     * @return
     */
    public boolean addRoles(int jobId, List<EmployeeRole> roleList){
        List<EmpVo> list = new ArrayList<>();
        for (EmployeeRole role : roleList) {
            EmpVo emp = new EmpVo();
            emp.setJobId(jobId);
            emp.setRoleId(role.getRoleId());
            list.add(emp);
        }
        return empMapper.addRoles(list);
    }
}
