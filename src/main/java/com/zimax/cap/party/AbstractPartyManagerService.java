package com.zimax.cap.party;

import com.zimax.cap.party.impl.PartyTypeTreeModel;

import java.util.List;
import java.util.Map;

/**
 * 抽象的参与者管理服务
 *
 * @author 苏尚文
 * @date 2022/12/2 17:04
 */
public abstract class AbstractPartyManagerService implements IPartyManagerService {

    public List<Party> getAllPartyList(String partyTypeID) {
        return doGetAllPartyList(partyTypeID);
    }

    public List<PartyType> getAllPartyTypeList() {
        return doGetAllPartyTypeList();
    }

    public List<PartyTypeRef> getAllPartyTypeRefList() {
        return doGetAllPartyTypeRefList();
    }

    public Map<String, List<Party>> getDirectAssociateChildPartyList(
            String parentPartyID, String parentPartyTypeID) {
        return doGetDirectAssociateChildPartyList(parentPartyID, parentPartyTypeID);
    }

    public Map<String, List<Party>> getDirectAssociateChildPartyList(
            String parentPartyID, String parentPartyTypeID,
            String[] childPartyTypes) {
        return doGetDirectAssociateChildPartyList(parentPartyID,
                parentPartyTypeID, childPartyTypes);
    }

    public Map<String, List<Party>> getDirectAssociateChildPartyList(
            String parentPartyID, String[] partyTypeRefs) {
        return doGetDirectAssociateChildPartyList(parentPartyID, partyTypeRefs);
    }

    public Map<String, List<Party>> getDirectAssociateParentPartyList(
            String childPartyID, String childPartyTypeID) {
        return doGetDirectAssociateParentPartyList(childPartyID, childPartyTypeID);
    }

    public Map<String, List<Party>> getDirectAssociateParentPartyList(
            String childPartyID, String childPartyTypeID,
            String[] parentPartyTypes) {
        return doGetDirectAssociateParentPartyList(childPartyID,
                childPartyTypeID, parentPartyTypes);
    }

    public Map<String, List<Party>> getDirectAssociateParentPartyList(
            String childPartyID, String[] partyTypeRefs) {
        return doGetDirectAssociateParentPartyList(childPartyID, partyTypeRefs);
    }

    public Party getPartyByPartyID(String partyID, String partyType) {
        return doGetPartyByPartyId(partyID, partyType);
    }

    public PartyType getPartyTypeByTypeID(String partyTypeID) {
        return doGetPartyTypeByTypeID(partyTypeID);
    }

    public PartyTypeRef getPartyTypeRefByRefID(String partyTypeRefID) {
        return doGetPartyTypeRefByRefID(partyTypeRefID);
    }

    public PartyTypeTreeModel getPartyTypeTreeModel() {
        return doGetPartyTypeTreeModel();
    }

    public List<PartyType> getRootPartyTypeList() {
        return doGetRootPartyTypeList();
    }

    public PartyTypeTreeModel getLoginPartyTypeTreeModel() {
        return doGetLoginPartyTypeTreeModel();
    }

    /**
     * @deprecated
     */
    public Map<String, List<Party>> getLoginPartyCache(String partyID, String partyTypeID) {
        return doGetLoginPartyCache(partyID, partyTypeID);
    }

    public List<Party> getRootPartyList(String partyTypeID) {
        return doGetRootPartyList(partyTypeID);
    }

    public Map<String, List<Party>> getAllParentPartyList(String partyID,
                                                          String partyTypeID) {
        return doGetAllParentPartyList(partyID, partyTypeID);
    }

    public Map<String, List<Party>> getScopePartyMap(String partyID,
                                                     String partyTypeID) {
        return doGetScopePartyMap(partyID, partyTypeID);
    }

    public List<Party> getAssociatePartyList(String partyID,
                                             String partyTypeID, String associatePartyType) {
        return doGetAssociatePartyList(partyID, partyTypeID, associatePartyType);
    }

    public abstract List<Party> doGetAllPartyList(String partyTypeID);

    public abstract List<PartyType> doGetAllPartyTypeList();

    public abstract List<PartyTypeRef> doGetAllPartyTypeRefList();

    public abstract Map<String, List<Party>> doGetDirectAssociateChildPartyList(
            String parentPartyID, String parentPartyTypeID);

    public abstract Map<String, List<Party>> doGetDirectAssociateChildPartyList(
            String parentPartyID, String parentPartyTypeID, String[] childPartyTypes);

    public abstract Map<String, List<Party>> doGetDirectAssociateChildPartyList(
            String parentPartyID, String[] partyTypeRefs);

    public abstract Map<String, List<Party>> doGetDirectAssociateParentPartyList(
            String childPartyID, String childPartyTypeID);

    public abstract Map<String, List<Party>> doGetDirectAssociateParentPartyList(
            String childPartyID, String childPartyTypeID, String[] parentPartyTypes);

    public abstract Map<String, List<Party>> doGetDirectAssociateParentPartyList(
            String childPartyID, String[] partyTypeRefs);

    public abstract Party doGetPartyByPartyId(String partyID, String partyType);

    public abstract PartyType doGetPartyTypeByTypeID(String partyTypeID);

    public abstract PartyTypeRef doGetPartyTypeRefByRefID(String partyTypeRefID);

    public abstract PartyTypeTreeModel doGetPartyTypeTreeModel();

    public abstract List<PartyType> doGetRootPartyTypeList();

    public abstract PartyTypeTreeModel doGetLoginPartyTypeTreeModel();

    /**
     * @deprecated
     */
    public abstract Map<String, List<Party>> doGetLoginPartyCache(
            String partyID, String partyTypeID);

    public abstract List<Party> doGetRootPartyList(String partyTypeID);

    public abstract Map<String, List<Party>> doGetAllParentPartyList(String partyID, String partyTypeID);

    public abstract Map<String, List<Party>> doGetScopePartyMap(String partyID, String partyTypeID);

    public abstract List<Party> doGetAssociatePartyList(String partyID, String partyTypeID, String associatePartyType);

}
