package com.zimax.components.coframe.rights.mapper;

import com.zimax.components.coframe.rights.pojo.PartyAuth;
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

    /**
     * 根据参与者编号和参与者类型获取其拥有的角色
     *
     * @param partyId 参与者编号
     * @param partyType 参与者类型
     * @return 其拥有的角色
     */
    List<Role> getRoleListByAuthParty(@Param("partyId") String partyId, @Param("partyType") String partyType);

    /**
     * 根据角色编号列表获取角色列表
     *
     * @param roleIds 角色编号列表
     * @return 角色列表
     */
    List<Role> queryRolesByRoleIds(List<String> roleIds);

    Role getRole(int roleId);

    int addRole(Role role);

    int deleteRole(int roleId);

    int updateRole(Role role);

    int deleteRoles(List<Integer> roleIds);

    int count(@Param("roleCode") String roleCode, @Param("roleName") String roleName,@Param("roleString") String roleString);

}
