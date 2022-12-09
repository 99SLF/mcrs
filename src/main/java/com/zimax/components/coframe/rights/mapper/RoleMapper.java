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

    Role getRole(int roleId);

    int addRole(Role role);

    int deleteRole(int roleId);

    int updateRole(Role role);

    int deleteRoles(List<Integer> roleIds);

    int count(@Param("roleCode") String roleCode, @Param("roleName") String roleName);

}
