package com.zimax.components.coframe.rights.service;

import com.sun.org.apache.xalan.internal.xsltc.dom.SimpleResultTreeImpl;
import com.zimax.cap.party.Party;
import com.zimax.components.coframe.rights.gradeauth.GradeAuthService;
import com.zimax.components.coframe.rights.mapper.PartyAuthMapper;
import com.zimax.components.coframe.rights.mapper.ResAuthMapper;
import com.zimax.components.coframe.rights.mapper.RoleMapper;
import com.zimax.components.coframe.rights.pojo.Role;

import com.zimax.components.coframe.tools.IConstants;
import com.zimax.mcrs.config.ChangeString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 角色服务
 */
public class RoleService {

    /**
     * 角色数据操作
     */
    private RoleMapper roleMapper;

    /**
     * 分级授权服务
     */
    private GradeAuthService gradeAuthService;

    /**
     * 资源授权数据操作
     */
    private ResAuthMapper resAuthMapper;

    /**
     * 参与者授权数据操作
     */
    private PartyAuthMapper partyAuthMapper;

    public RoleMapper getRoleMapper() {
        return roleMapper;
    }

    public void setRoleMapper(RoleMapper roleMapper) {
        this.roleMapper = roleMapper;
    }

    public GradeAuthService getGradeAuthService() {
        return gradeAuthService;
    }

    public void setGradeAuthService(GradeAuthService gradeAuthService) {
        this.gradeAuthService = gradeAuthService;
    }

    public ResAuthMapper getResAuthMapper() {
        return resAuthMapper;
    }

    public void setResAuthMapper(ResAuthMapper resAuthMapper) {
        this.resAuthMapper = resAuthMapper;
    }

    public PartyAuthMapper getPartyAuthMapper() {
        return partyAuthMapper;
    }

    public void setPartyAuthMapper(PartyAuthMapper partyAuthMapper) {
        this.partyAuthMapper = partyAuthMapper;
    }

    /**
     * 查询所有角色信息
     *
     * @return
     */
    public List<Role> queryRoles(String page, String limit, String roleCode, String roleName, String order, String field) {
//        Page<Role> rowPage = new Page(page, limit);
//        QueryWrapper<Role> queryWrapper = new QueryWrapper<>();
//        List<Role> roleList = (List<Role>) roleMapper.selectPage();
        List<Party> authorizedRolePartyList = gradeAuthService.getManagedRoleList();
        String str="";
        if (!(authorizedRolePartyList == null || authorizedRolePartyList.size() == 0)) {
            List<String> roleIdList = new ArrayList<String>();
            for (int i=0;i<authorizedRolePartyList.size();i++) {
                str=str+ authorizedRolePartyList.get(i).getId();
                if(i!=authorizedRolePartyList.size()-1){
                    str+=",";
                }
            }
        }
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
        map.put("roleString",str);
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
        List<Party> authorizedRolePartyList = gradeAuthService.getManagedRoleList();
        String str="";
        if (!(authorizedRolePartyList == null || authorizedRolePartyList.size() == 0)) {
            List<String> roleIdList = new ArrayList<String>();
            for (int i=0;i<authorizedRolePartyList.size();i++) {
                str=str+ authorizedRolePartyList.get(i).getId();
                if(i!=authorizedRolePartyList.size()-1){
                    str+=",";
                }
            }
        }
        return roleMapper.count(roleCode, roleName,str);
    }

    /**
     * 获取授权的角色列表
     *
     * @return 授权的角色列表
     */
    public List<Role> queryAuthorizedRoleList() {
        // 获取可管控角色参与者列表
        List<Party> authorizedRolePartyList = gradeAuthService.getManagedRoleList();
        if (authorizedRolePartyList == null || authorizedRolePartyList.size() == 0) {
            return new ArrayList<>();
        }

        // 获取角色ID列表
        List<String> roleIdList = new ArrayList<String>();
        for (Party authorizedRoleParty : authorizedRolePartyList) {
            roleIdList.add(authorizedRoleParty.getId());
        }

        return roleMapper.queryRolesByRoleIds(roleIdList);
    }

    public void deleteRoleResRelationBatch(List<Integer> roleIds) {
        for (int roleId : roleIds) {
            if (countRoleResRelation(roleId) > 0) {
                deleteRoleResRelation(roleId);
            }
        }
    }

    public int countRoleResRelation(int roleId) {
        return resAuthMapper.countRoleResRelation(roleId, IConstants.ROLE_PARTY_TYPE_ID);
    }

    public void deleteRoleResRelation(int roleId) {
        resAuthMapper.deleteRoleResRelation(roleId, IConstants.ROLE_PARTY_TYPE_ID);
    }

    public void deleteRolePartyRelationBatch(List<Integer> roleIds) {
        for (int roleId : roleIds) {
            if (countRolePartyRelation(roleId) > 0) {
                deleteRolePartyRelation(roleId);
            }
        }
    }

    public int countRolePartyRelation(int roleId) {
        return partyAuthMapper.countRolePartyRelation(roleId, IConstants.ROLE_PARTY_TYPE_ID);
    }

    public void deleteRolePartyRelation(int roleId) {
        partyAuthMapper.deleteRolePartyRelation(roleId, IConstants.ROLE_PARTY_TYPE_ID);
    }
    /**
     * 在添加角色时判断角色代码是否已存在
     * @param roleCode 角色代码
     * @return
     */
    public int checkRoleCode(String roleCode) {
        return roleMapper.checkRoleCode(roleCode);
    }


}
