package com.zimax.components.coframe.auth.party.config;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 苏尚文
 * @date 2022/12/8 18:45
 */
public class PartyModel implements Serializable {

    private static final long serialVersionUID = 89671471136041552L;

    private List<PartyTypeModel> partyTypeModelList = new ArrayList<PartyTypeModel>();

    private List<PartyTypeRefModel> partyTypeRefModelList = new ArrayList<PartyTypeRefModel>();

    public List<PartyTypeModel> getPartyTypeModelList() {
        return partyTypeModelList;
    }

    public void addPartyTypeModel(PartyTypeModel partyTypeModel) {
        this.partyTypeModelList.add(partyTypeModel);
    }

    public List<PartyTypeRefModel> getPartyTypeRefModelList() {
        return partyTypeRefModelList;
    }

    public void addPartyTypeRefModel(PartyTypeRefModel partyTypeRefModel) {
        this.partyTypeRefModelList.add(partyTypeRefModel);
    }
}