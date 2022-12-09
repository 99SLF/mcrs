package com.zimax.components.coframe.auth.service;

import com.zimax.cap.party.Party;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 * Party授权模型
 *
 * @author 苏尚文
 * @date 2022/12/8 18:27
 */
public class PartyAuthModel {

    private Map<String, Party> partyMap = new HashMap<String, Party>();

    /**
     * 由于party可能是多个，该处采用map存储，最好取value
     */
    private Map<String, Party> roleMap = new HashMap<String, Party>();

    public void addParty(Party party) {
        partyMap.put(getPartyKey(party), party);
    }

    public void addRoleparty(Party party) {
        roleMap.put(getPartyKey(party), party);
    }

    public Collection<Party> getPartys() {
        return partyMap.values();
    }

    public Collection<Party> getRoles() {
        return roleMap.values();
    }

    private String getPartyKey(Party party) {
        return party.getId() + "_" + party.getPartyTypeId();
    }
}
