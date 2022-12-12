package com.zimax.cap.party.manager;

import com.zimax.cap.party.IPartyTypeDataService;
import com.zimax.cap.party.PartyType;

import java.util.HashMap;
import java.util.Map;

/**
 * 参与者类型管理
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public class PartyTypeManager {

    private Map<String, PartyType> partyTypeMap = new HashMap();

    private Map<String, IPartyTypeDataService> partyTypeDataServiceMap = new HashMap();

    private static PartyTypeManager instance = null;

    public static PartyTypeManager getInstance() {
        if (instance == null) {
            instance = new PartyTypeManager();
        }
        return instance;
    }

    public PartyType getPartyType(String typeID) {
        return this.partyTypeMap.get(typeID);
    }

    public void putPartyType(String typeID, PartyType partyType) {
        if ((typeID == null) || (typeID.trim().length() == 0)) {
            throw new IllegalArgumentException("typeID is null!");
        }
        if (partyType == null) {
            throw new IllegalArgumentException("partyType is null!");
        }
        this.partyTypeMap.put(typeID, partyType);
    }

    public void removePartyType(String typeID) {
        if ((typeID == null) || (typeID.trim().length() == 0)) {
            return;
        }
        this.partyTypeMap.remove(typeID);
    }

    public IPartyTypeDataService getPartyTypeDataService(String typeID) {
        return this.partyTypeDataServiceMap.get(typeID);
    }

    public void putPartyTypeDataService(String typeID,
                                        IPartyTypeDataService partyTypeDataService) {
        if ((typeID == null) || (typeID.trim().length() == 0)) {
            throw new IllegalArgumentException("typeID is null!");
        }
        if (partyTypeDataService == null) {
            throw new IllegalArgumentException("partyTypeDataService is null!");
        }
        this.partyTypeDataServiceMap.put(typeID, partyTypeDataService);
    }

    public void removePartyTypeDataService(String typeID) {
        if ((typeID == null) || (typeID.trim().length() == 0)) {
            return;
        }
        this.partyTypeDataServiceMap.remove(typeID);
    }

    public Map<String, PartyType> getPartyTypeMap() {
        return this.partyTypeMap;
    }

    public Map<String, IPartyTypeDataService> getPartyTypeDataServiceMap() {
        return this.partyTypeDataServiceMap;
    }
}
