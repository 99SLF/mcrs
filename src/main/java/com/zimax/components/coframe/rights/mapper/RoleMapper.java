package com.zimax.components.coframe.rights.mapper;

import com.zimax.components.coframe.rights.pojo.Role;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 角色数据操作
 */
@Mapper
public interface RoleMapper {
    public List<Role> queryRoles();
    public Role getRole(int id);
    public void addRole(Role role);
    public void removeRole(int roleId);
    public void updateRole(Role role);

}
