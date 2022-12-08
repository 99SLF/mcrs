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
     *
     * @return
     */
    public List<Role> queryRoles(String page, String limit, String roleCode, String roleName, String order, String field) {
//        Page<Role> rowPage = new Page(page, limit);
//        QueryWrapper<Role> queryWrapper = new QueryWrapper<>();
//        List<Role> roleList = (List<Role>) roleMapper.selectPage();
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "role_code");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("roleCode", roleCode);
        map.put("roleName", roleName);
        return roleMapper.queryRoles(map);
    }

    /**
     * 添加角色信息
     *
     * @param role 角色
     */
    public int addRole(Role role) {
        if (roleMapper.addRole(role) > 0) {
            return 0;
        } else {
            return 1;
        }
    }

    /**
     * 根绝角色编码删除
     *
     * @param roleId 角色编码
     */
    public int deleteRole(int roleId) {
        if (roleMapper.deleteRole(roleId) > 0) {
            return 0;
        } else {
            return 1;
        }
    }

    /**
     * 更新角色
     *
     * @param role 角色信息
     */
    public int updateRole(Role role) {
        if (roleMapper.updateRole(role) > 0) {
            return 0;
        } else {
            return 1;
        }
    }

    /**
     * 根据角色编码查询
     *
     * @param roleId 角色编号
     */
    public Role getRole(int roleId) {
        return roleMapper.getRole(roleId);
    }

    /**
     * 批量删除角色
     *
     * @param roleIds 角色编号
     */
    public int deleteRoles(List<Integer> roleIds) {
        if (roleMapper.deleteRoles(roleIds) > 0) {
            return 0;
        } else {
            return 1;
        }
    }

    /**
     * 查询记录
     */
    public int count(String roleCode, String roleName) {
        return roleMapper.count(roleCode, roleName);
    }

}
