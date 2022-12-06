package com.zimax.components.coframe.rights.mapper;

import com.zimax.components.coframe.rights.pojo.Role;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 角色数据操作
 */
@Mapper
public interface RoleMapper {
    List<Role> queryRoles();
    Role getRole(int id);
    void addRole(Role role);
    void deleteRole(int roleId);
    void updateRole(Role role);
    void deleteRoles(List<Integer> roleIds);

}
