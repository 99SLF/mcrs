package com.zimax.cap.party.manager;

import com.zimax.cap.party.Party;
import com.zimax.cap.party.PartyType;
import com.zimax.cap.party.PartyTypeRef;
import com.zimax.cap.party.impl.PartyTypeTreeModel;
import com.zimax.cap.utility.StringUtil;

import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * 参与者运行管理器
 *
 * @author 苏尚文
 * @date 2022/12/2 16:45
 */
public class PartyRuntimeManager {

    private static PartyRuntimeManager instance = null;

    public static PartyRuntimeManager getInstance() {
        if (instance == null) {
            instance = new PartyRuntimeManager();
        }
        return instance;
    }

    public Party getPartyByPartyID(String partyID, String partyTypeID) {
        if ((StringUtil.isEmpty(partyID)) || (StringUtil.isEmpty(partyTypeID))) {
            return null;
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getPartyByPartyID(partyID, partyTypeID);
    }

    public List<PartyType> getAllPartyTypeList() {
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getAllPartyTypeList();
    }

    public List<PartyTypeRef> getAllPartyTypeRefList() {
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getAllPartyTypeRefList();
    }

    public PartyType getPartyTypeByTypeID(String partyTypeID) {
        if (StringUtil.isEmpty(partyTypeID)) {
            return null;
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getPartyTypeByTypeID(partyTypeID);
    }

    public PartyTypeRef getPartyTypeRefByRefID(String partyTypeRefID) {
        if (StringUtil.isEmpty(partyTypeRefID)) {
            return null;
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getPartyTypeRefByRefID(partyTypeRefID);
    }

    public List<Party> getAllPartyList(String partyTypeID) {
        if (StringUtil.isEmpty(partyTypeID)) {
            return null;
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getAllPartyList(partyTypeID);
    }

    public List<Party> getRootPartyList(String partyTypeID) {
        if (StringUtil.isEmpty(partyTypeID)) {
            return null;
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getRootPartyList(partyTypeID);
    }

    public Map<String, List<Party>> getDirectAssociateChildPartyList(
            String parentPartyID, String parentPartyTypeID) {
        if ((StringUtil.isEmpty(parentPartyID))
                || (StringUtil.isEmpty(parentPartyTypeID))) {
            return Collections.emptyMap();
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getDirectAssociateChildPartyList(parentPartyID,
                        parentPartyTypeID);
    }

    public Map<String, List<Party>> getDirectAssociateChildPartyList(
            String parentPartyID, String parentPartyTypeID,
            String[] childPartyTypes) {
        if ((StringUtil.isEmpty(parentPartyID))
                || (StringUtil.isEmpty(parentPartyTypeID))) {
            return Collections.emptyMap();
        }
        if ((childPartyTypes == null) || (childPartyTypes.length == 0)) {
            return Collections.emptyMap();
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getDirectAssociateChildPartyList(parentPartyID,
                        parentPartyTypeID, childPartyTypes);
    }

    public Map<String, List<Party>> getDirectAssociateChildPartyList(
            String parentPartyID, String[] partyTypeRefs) {
        if (StringUtil.isEmpty(parentPartyID)) {
            return Collections.emptyMap();
        }
        if ((partyTypeRefs == null) || (partyTypeRefs.length == 0)) {
            return Collections.emptyMap();
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getDirectAssociateChildPartyList(parentPartyID, partyTypeRefs);
    }

    public Map<String, List<Party>> getDirectAssociateParentPartyList(
            String childPartyID, String childPartyTypeID) {
        if ((StringUtil.isEmpty(childPartyID))
                || (StringUtil.isEmpty(childPartyTypeID))) {
            return Collections.emptyMap();
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getDirectAssociateParentPartyList(childPartyID,
                        childPartyTypeID);
    }

    public Map<String, List<Party>> getDirectAssociateParentPartyList(
            String childPartyID, String childPartyTypeID,
            String[] parentPartyTypes) {
        if ((StringUtil.isEmpty(childPartyID))
                || (StringUtil.isEmpty(childPartyTypeID))) {
            return Collections.emptyMap();
        }
        if ((parentPartyTypes == null) || (parentPartyTypes.length == 0)) {
            return Collections.emptyMap();
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getDirectAssociateParentPartyList(childPartyID,
                        childPartyTypeID, parentPartyTypes);
    }

    public Map<String, List<Party>> getDirectAssociateParentPartyList(
            String childPartyID, String[] partyTypeRefs) {
        if (StringUtil.isEmpty(childPartyID)) {
            return Collections.emptyMap();
        }
        if ((partyTypeRefs == null) || (partyTypeRefs.length == 0)) {
            return Collections.emptyMap();
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getDirectAssociateParentPartyList(childPartyID, partyTypeRefs);
    }

    public PartyTypeTreeModel getPartyTypeTreeModel() {
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getPartyTypeTreeModel();
    }

    public List<PartyType> getRootPartyTypeList() {
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getRootPartyTypeList();
    }

    /**
     * @deprecated
     */
    public Map<String, List<Party>> getLoginPartyCache(String partyID,
                                                       String partyTypeID) {
        if ((StringUtil.isEmpty(partyID)) || (StringUtil.isEmpty(partyTypeID))) {
            return Collections.emptyMap();
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getLoginPartyCache(partyID, partyTypeID);
    }

    public PartyTypeTreeModel getLoginPartyTypeTreeModel() {
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getLoginPartyTypeTreeModel();
    }

    public Map<String, List<Party>> getAllParentPartyList(String partyID,
                                                          String partyTypeID) {
        if ((StringUtil.isEmpty(partyID)) || (StringUtil.isEmpty(partyTypeID))) {
            return Collections.emptyMap();
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getAllParentPartyList(partyID, partyTypeID);
    }

    public Map<String, List<Party>> getScopePartyMap(String partyID,
                                                     String partyTypeID) {
        if ((StringUtil.isEmpty(partyID)) || (StringUtil.isEmpty(partyTypeID))) {
            return Collections.emptyMap();
        }
        return PartyManagerServiceLoader.getCurrentPartyManagerService()
                .getScopePartyMap(partyID, partyTypeID);
    }

    public List<Party> getAssociatePartyList(String partyID,
                                             String partyTypeID, String associatePartyType) {
        if ((StringUtil.isEmpty(partyID)) || (StringUtil.isEmpty(partyTypeID))) {
            return Collections.emptyList();
        }
        return PartyManagerServiceLoader
                .getCurrentPartyManagerService()
                .getAssociatePartyList(partyID, partyTypeID, associatePartyType);
    }
}
