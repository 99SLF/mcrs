package com.zimax.components.coframe.auth.party.impl;

import com.zimax.cap.party.IPartyTypeDataService;
import com.zimax.cap.party.Party;
import com.zimax.components.coframe.auth.party.manager.DefaultRoleManager;
import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.components.coframe.tools.IConstants;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.ArrayList;
import java.util.List;

/**
 * 角色参与者类型数据服务
 *
 * @author 苏尚文
 * @date 2022/12/8 19:17
 */
public class RolePartyTypeDataService implements IPartyTypeDataService {

    private DefaultRoleManager bean;

    public RolePartyTypeDataService() {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        bean = context.getBean(DefaultRoleManager.SPRING_BEAN_NAME, DefaultRoleManager.class);
    }

    @Override
    public List<Party> getAllPartyList() {
        Role[] roles = bean.getAllRoleList();
        List<Party> returnList = new ArrayList<Party>();
        if (roles != null) {
            for (Role role : roles) {
                Party party = new Party(IConstants.ROLE_PARTY_TYPE_ID, String.valueOf(role.getRoleId()), role.getRoleCode(), role.getRoleName());
                returnList.add(party);
            }
        }
        return returnList;
    }

    @Override
    public Party getPartyByPartyId(String partyId) {
        Role role = bean.getRoleByRoleId(partyId);
        if (role == null) {
            return null;
        }
        return new Party(IConstants.ROLE_PARTY_TYPE_ID, String.valueOf(role.getRoleId()), role.getRoleCode(), role.getRoleName());
    }

    @Override
    public List<Party> getRootPartyList() {
        return this.getAllPartyList();
    }

}