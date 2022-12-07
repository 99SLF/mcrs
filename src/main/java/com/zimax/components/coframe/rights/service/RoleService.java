package com.zimax.components.coframe.rights.service;

import com.sun.org.apache.xalan.internal.xsltc.dom.SimpleResultTreeImpl;
import com.zimax.components.coframe.rights.mapper.RoleMapper;
import com.zimax.components.coframe.rights.pojo.Role;

import com.zimax.mcrs.config.ChangeString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 角色服务
 */
@Service
public class RoleService {

    /**
     * 角色数据操作
     */
    @Autowired
    private RoleMapper roleMapper;

    /**
     * 查询所有角色信息
     * @return
     */
    public List<Role> queryRoles(int page, int limit, String roleCode, String roleName, String order, String field) {
//        Page<Role> rowPage = new Page(page, limit);
//        QueryWrapper<Role> queryWrapper = new QueryWrapper<>();
//        List<Role> roleList = (List<Role>) roleMapper.selectPage();
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","create_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        map.put("begin",limit*(page-1));
        map.put("limit",limit);
        map.put("roleCode",roleCode);
        map.put("roleName",roleName);
        return roleMapper.queryRoles(map);
    }

    /**
     * 添加角色信息
     * @param role 角色
     */
    public void addRole(Role role) {
        roleMapper.addRole(role);
    }

    /**
     * 根绝角色编码删除
     * @param roleId 角色编码
     */
    public void deleteRole(int roleId) {
        roleMapper.deleteRole(roleId);
    }

    /**
     * 更新角色
     * @param role 角色信息
     */
    public void updateRole(Role role) {
        roleMapper.updateRole(role);
    }

    /**
     * 根据角色编码查询
     * @param roleId 角色编号
     */
    public Role getRole(int roleId) {
       return roleMapper.getRole(roleId);
    }

    /**
     * 批量删除角色
     * @param roleIds 角色编号
     */
    public void deleteRoles(List<Integer> roleIds) {
        roleMapper.deleteRoles(roleIds);
    }

    /**
     * 查询记录
     */
    public int count(String roleCode, String roleName){
        return roleMapper.count(roleCode,roleName);
    }

}
