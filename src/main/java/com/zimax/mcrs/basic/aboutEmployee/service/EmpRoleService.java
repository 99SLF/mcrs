package com.zimax.mcrs.basic.aboutEmployee.service;



import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.mcrs.basic.aboutEmployee.mapper.EmpRoleMapper;
import com.zimax.mcrs.basic.aboutEmployee.pojo.EmployeeRole;
import com.zimax.mcrs.config.ChangeString;
import org.omg.CORBA.OBJ_ADAPTER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EmpRoleService {
    @Autowired
    private EmpRoleMapper empRoleMapper;



    /**
     * 查询角色表总记录数
     * @return
     */
    public int count(){
        return empRoleMapper.count();
    }

    /**
     * 添加一条角色记录
     * @param employeeRole 角色对象
     * @return
     */
    public void add(EmployeeRole employeeRole){
        try {
            String creator = DataContextManager.current().getMUODataContext().getUserObject().getUserId();
            employeeRole.setCreator(creator);
            Date date = new Date();
            employeeRole.setCreateTime(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        empRoleMapper.add(employeeRole);

    }

    /**
     * 删除一条角色记录
     * @param roleId 角色主键
     * @return
     */
    public void delete(int roleId){
        empRoleMapper.delete(roleId);
    }

    /**
     * 修改角色信息
     * @param employeeRole
     * @return
     */
    public void update(EmployeeRole employeeRole){
        empRoleMapper.update(employeeRole);
    }

    /**
     * 分页条件查询角色
     * @param page 页码
     * @param limit 记录数
     * @param roleCode 角色代码
     * @param roleName 角色名字
     * @return
     */
    public List<EmployeeRole> queryRole(String page, String limit, String roleCode, String roleName, String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null){
            map.put("order","asc");
        }else {
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null){
            map.put("begin",Integer.parseInt(limit)*(Integer.parseInt(page)-1));
            map.put("limit",Integer.parseInt(limit));
        }
        map.put("roleCode",roleCode);
        map.put("roleName",roleName);
        return empRoleMapper.queryRole(map);
    }

    /**
     * 角色代码的唯一性校验
     * @param roleCode
     * @return
     */
    public int checkRoleCode(String  roleCode){
        return empRoleMapper.checkRoleCode(roleCode);
    }
}
