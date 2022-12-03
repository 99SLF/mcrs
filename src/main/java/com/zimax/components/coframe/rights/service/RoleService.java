package com.zimax.components.coframe.rights.service;

import com.zimax.components.coframe.rights.mapper.RoleMapper;
import com.zimax.components.coframe.rights.pojo.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
    public List<Role> queryRoles(){
//        Page<Role> rowPage = new Page(page, limit);
//        QueryWrapper<Role> queryWrapper = new QueryWrapper<>();
//        List<Role> roleList = (List<Role>) roleMapper.selectPage();
        System.out.println("success---");
        System.out.println(roleMapper.queryRoles());
        System.out.println("success");
        return roleMapper.queryRoles();
    }

    /**
     * 添加角色信息
     * @param role 角色
     */
    public void addRole(Role role){

    }

    /**
     * 根绝角色编码删除
     * @param roleId 角色编码
     */
    public void deleteById(int roleId){

    }

    /**
     * 更新角色
     */
    public void updateRole(Role role){

    }

    /**
     * 根绝角色编码查询
     */
    public Role getRole(int roleId){
        System.out.println(roleMapper.getRole(roleId));
        return null;
    }

}
