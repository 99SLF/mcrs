package com.zimax.components.coframe.rights.mapper;

import com.zimax.components.coframe.rights.pojo.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 角色数据操作
 */
@Mapper
public interface RoleMapper {
    List<Role> queryRoles(Map map);
    Role getRole(int id);
    void addRole(Role role);
    void deleteRole(int roleId);
    void updateRole(Role role);
    void deleteRoles(List<Integer> roleIds);
    int count(@Param("roleCode") String roleCode, @Param("roleName") String roleName);

}
