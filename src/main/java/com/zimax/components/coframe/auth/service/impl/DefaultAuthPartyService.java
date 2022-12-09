package com.zimax.components.coframe.auth.service.impl;

import com.zimax.cap.auth.manager.AuthRuntimeManager;
import com.zimax.cap.party.Party;
import com.zimax.cap.party.manager.PartyRuntimeManager;
import com.zimax.components.coframe.auth.service.IAuthPartyService;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 默认授权Party服务
 *
 * @author 苏尚文
 * @date 2022/12/8 18:25
 */
public class DefaultAuthPartyService implements IAuthPartyService {

    private String partyType;

    public DefaultAuthPartyService(String partyType) {
        this.partyType = partyType;
    }

    /**
     * 查询直接关联的类型
     */
    public List<Party> getAssociateAuthPartyList(String partyId) {
        String[] parentPartyTypes = this.getParentPartyTypes();
        if (parentPartyTypes == null || parentPartyTypes.length == 0) {
            return new ArrayList<Party>();

        }
        List<Party> parties = new ArrayList<Party>();
        Map<String, List<Party>> map = PartyRuntimeManager.getInstance()
                .getDirectAssociateParentPartyList(partyId, this.partyType,
                        parentPartyTypes);
        if (map != null) {
            Iterator<String> it = map.keySet().iterator();
            while (it.hasNext()) {
                String partyTypeID = it.next();
                List<Party> partyList = map.get(partyTypeID);
                parties.addAll(partyList);
            }

        }
        return parties;
    }
    /**
     * 子类一般重载该方法，指定查询哪些直接关联的父类型
     * @return
     */
    public String[] getParentPartyTypes() {
        return new String[0];
    }

    public List<Party> getAssociateAuthRoles(String partyId) {
        Party party = new Party(this.partyType, partyId, partyId, partyId);
        List<Party> partyList = AuthRuntimeManager.getInstance()
                .getDirectRolePartyListByParty(party);
        if (partyList == null) {
            partyList = new ArrayList<Party>();
        }
        return partyList;
    }

}
