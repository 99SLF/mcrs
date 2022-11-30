package com.zimax.mcrs.rights.service;

import com.zimax.mcrs.rights.mapper.RoleMapper;
import com.zimax.mcrs.rights.pojo.Role;
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
    public List<Role> queryRoles(int page, int limit){
//        Page<Role> rowPage = new Page(page, limit);
//        QueryWrapper<Role> queryWrapper = new QueryWrapper<>();
//        List<Role> roleList = (List<Role>) roleMapper.selectPage();
        System.out.println("success---");
        System.out.println(roleMapper.findAll());
        System.out.println("success");
        return null;
    }

   /* *//**
     * 添加角色信息
     * @param role 角色
     *//*
    public void addRole(Role role){
        roleMapper.insert(role);
    }

    *//**
     * 根绝角色编码删除
     * @param roleId 角色编码
     *//*
    public void deleteById(int roleId){
        roleMapper.deleteById(roleId);
    }

    *//**
     * 更新角色
     *//*
    public void updateRole(Role role){
       roleMapper.updateById(role);
    }

    *//**
     * 查询角色
     *//*
    public List<Role> queryAll(){
        return roleMapper.selectList(null);
    }

    *//**
     * 根绝角色编码查询
     *//*
    public Role query(int roleId){
        return roleMapper.selectById(roleId);
    }*/

}
