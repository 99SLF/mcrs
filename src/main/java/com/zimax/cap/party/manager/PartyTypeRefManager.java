package com.zimax.cap.party.manager;

import com.zimax.cap.party.IPartyTypeRefDataService;
import com.zimax.cap.party.PartyType;
import com.zimax.cap.party.PartyTypeRef;
import com.zimax.cap.party.impl.PartyTypeTreeModel;
import com.zimax.cap.party.util.PartyUtil;

import java.util.*;

/**
 * 参与者类型引用管理器
 *
 * @author 苏尚文
 * @date 2022/12/2 17:32
 */
public class PartyTypeRefManager {

    private Map<String, PartyTypeRef> partyTypeRefMap = new HashMap();

    private Map<String, IPartyTypeRefDataService> partyTypeRefDataServiceMap = new HashMap();

    private PartyTypeTreeModel partyTypeTreeModel = null;

    private PartyTypeTreeModel loginPartyTypeTreeModel = null;

    private static PartyTypeRefManager instance = null;

    public void calculateLoginPartyTypeTreeModel() {
        this.loginPartyTypeTreeModel = new PartyTypeTreeModel();
        Map<String, PartyType> partyTypeMap = PartyTypeManager.getInstance()
                .getPartyTypeMap();

        Iterator<String> it = partyTypeMap.keySet().iterator();
        PartyType rolePartyType = null;
        while (it.hasNext()) {
            String key = (String) it.next();
            PartyType partyType = (PartyType) partyTypeMap.get(key);
            if (partyType.isRole()) {
                rolePartyType = partyType;
                break;
            }
        }
        if (rolePartyType != null) {
            PartyTypeTreeModel.PartyTypeTreeNode rootRoleTreeNode = new PartyTypeTreeModel.PartyTypeTreeNode(
                    rolePartyType.getTypeId());
            this.loginPartyTypeTreeModel.addRootPartyTreeNode(rootRoleTreeNode);
            addLoginChildTreeNodes(partyTypeMap, rootRoleTreeNode);
        }
    }

    public void calculatePartyTypeTreeModel() {
        this.partyTypeTreeModel = new PartyTypeTreeModel();

        Map<String, PartyType> partyTypeMap = PartyTypeManager.getInstance()
                .getPartyTypeMap();
        Iterator<String> it = partyTypeMap.keySet().iterator();
        while (it.hasNext()) {
            String partyTypeID = (String) it.next();
            PartyType partyType = (PartyType) partyTypeMap.get(partyTypeID);
            if ((partyType.isShowAtRoot()) && (partyType.isShowInTree())) {
                PartyTypeTreeModel.PartyTypeTreeNode rootTreeNode = new PartyTypeTreeModel.PartyTypeTreeNode(
                        partyTypeID);
                this.partyTypeTreeModel.addRootPartyTreeNode(rootTreeNode);
                if (partyType.isLeaf()) {
                    String selfRefID = hasSelfRelation(partyType.getTypeId());
                    if (selfRefID != null) {
                        rootTreeNode.setSelfRelation(true);
                        rootTreeNode.setSelfPartyTypeRefID(selfRefID);
                    }
                } else {
                    addChildTreeNodes(partyTypeMap, rootTreeNode);
                }
            }
        }
        sortPartyTypeTreeModel();
    }

    private void sortPartyTypeTreeModel() {
        if (this.partyTypeTreeModel != null) {
            sortPartyTypeTreeNode(this.partyTypeTreeModel
                    .getRootPartyTreeNode());
        }
    }

    private void sortPartyTypeTreeNode(
            List<PartyTypeTreeModel.PartyTypeTreeNode> partyTreeNodeList) {
        if ((partyTreeNodeList == null) || (partyTreeNodeList.isEmpty())) {
            return;
        }
        for (PartyTypeTreeModel.PartyTypeTreeNode childNode : partyTreeNodeList) {
            sortPartyTypeTreeNode(childNode.getChildrenTypeTreeNode());
        }
        Collections.sort(partyTreeNodeList,
                PartyUtil.getPartyTypeTreeNodeComparator());
    }

    private void addChildTreeNodes(Map<String, PartyType> partyTypeMap,
                                   PartyTypeTreeModel.PartyTypeTreeNode parentPartyTypeTreeNode) {
        Iterator<String> it = this.partyTypeRefMap.keySet().iterator();
        while (it.hasNext()) {
            String refID = (String) it.next();
            PartyTypeRef partyTypeRef = (PartyTypeRef) this.partyTypeRefMap
                    .get(refID);
            PartyType parentPartyType = partyTypeRef.getParentPartyType();
            if (parentPartyType.getTypeId().equals(
                    parentPartyTypeTreeNode.getPartyTypeID())) {
                PartyType childPartyType = partyTypeRef.getChildPartyType();
                if (childPartyType.getTypeId().equals(
                        parentPartyType.getTypeId())) {
                    if (!parentPartyTypeTreeNode.isSelfRelation()) {
                        parentPartyTypeTreeNode.setSelfRelation(true);
                        parentPartyTypeTreeNode.setSelfPartyTypeRefID(refID);
                    }
                } else if ((childPartyType.isShowInTree()) &&

                        (!childPartyType.isShowAtRoot())) {
                    if (childPartyType.isLeaf()) {
                        PartyTypeTreeModel.PartyTypeTreeNode treeNode = new PartyTypeTreeModel.PartyTypeTreeNode(
                                childPartyType.getTypeId(),
                                parentPartyTypeTreeNode);
                        treeNode.setPartyTypeRefID(refID);

                        String selfRefID = hasSelfRelation(treeNode
                                .getPartyTypeID());
                        if (selfRefID != null) {
                            treeNode.setSelfRelation(true);
                            treeNode.setSelfPartyTypeRefID(refID);
                        }
                    } else {
                        PartyTypeTreeModel.PartyTypeTreeNode treeNode = new PartyTypeTreeModel.PartyTypeTreeNode(
                                childPartyType.getTypeId(),
                                parentPartyTypeTreeNode);
                        treeNode.setPartyTypeRefID(refID);
                        addChildTreeNodes(partyTypeMap, treeNode);
                    }
                }
            }
        }
    }

    private void addLoginChildTreeNodes(Map<String, PartyType> partyTypeMap,
                                        PartyTypeTreeModel.PartyTypeTreeNode parentPartyTypeTreeNode) {
        Iterator<String> it = this.partyTypeRefMap.keySet().iterator();
        while (it.hasNext()) {
            String refID = (String) it.next();
            PartyTypeRef partyTypeRef = (PartyTypeRef) this.partyTypeRefMap
                    .get(refID);
            PartyType parentPartyType = partyTypeRef.getParentPartyType();
            if (parentPartyType.getTypeId().equals(
                    parentPartyTypeTreeNode.getPartyTypeID())) {
                PartyType childPartyType = partyTypeRef.getChildPartyType();
                if (childPartyType.getTypeId().equals(
                        parentPartyType.getTypeId())) {
                    if (!parentPartyTypeTreeNode.isSelfRelation()) {
                        parentPartyTypeTreeNode.setSelfRelation(true);
                        parentPartyTypeTreeNode.setSelfPartyTypeRefID(refID);
                    }
                } else {
                    PartyTypeTreeModel.PartyTypeTreeNode treeNode = new PartyTypeTreeModel.PartyTypeTreeNode(
                            childPartyType.getTypeId(), parentPartyTypeTreeNode);
                    treeNode.setPartyTypeRefID(refID);
                    addLoginChildTreeNodes(partyTypeMap, treeNode);
                }
            }
        }
    }

    private String hasSelfRelation(String partyTypeID) {
        Iterator<String> it = this.partyTypeRefMap.keySet().iterator();
        while (it.hasNext()) {
            String refID = (String) it.next();
            PartyTypeRef partyTypeRef = (PartyTypeRef) this.partyTypeRefMap
                    .get(refID);
            String parentTypeID = partyTypeRef.getParentPartyType().getTypeId();
            if ((partyTypeID.equals(parentTypeID))
                    && (partyTypeRef.getChildPartyType().getTypeId()
                    .equals(parentTypeID))) {
                return refID;
            }
        }
        return null;
    }

    public PartyTypeRef getPartyTypeRef(String refID) {
        return (PartyTypeRef) this.partyTypeRefMap.get(refID);
    }

    public void putPartyTypeRef(String refID, PartyTypeRef partyTypeRef) {
        if ((refID == null) || (refID.trim().length() == 0)) {
            throw new IllegalArgumentException("refID is null!");
        }
        if (partyTypeRef == null) {
            throw new IllegalArgumentException("partyTypeRef is null!");
        }
        this.partyTypeRefMap.put(refID, partyTypeRef);
    }

    public void removePartyTypeRef(String refID) {
        if ((refID == null) || (refID.trim().length() == 0)) {
            return;
        }
        this.partyTypeRefMap.remove(refID);
    }

    public IPartyTypeRefDataService getPartyTypeRefDataService(String refID) {
        return (IPartyTypeRefDataService) this.partyTypeRefDataServiceMap
                .get(refID);
    }

    public void putPartyTypeRefDataService(String refID,
                                           IPartyTypeRefDataService partyTypeRefDataService) {
        if ((refID == null) || (refID.trim().length() == 0)) {
            throw new IllegalArgumentException("refID is null!");
        }
        if (partyTypeRefDataService == null) {
            throw new IllegalArgumentException(
                    "partyTypeRefDataService is null!");
        }
        this.partyTypeRefDataServiceMap.put(refID, partyTypeRefDataService);
    }

    public void removePartyTypeRefDataService(String refID) {
        if ((refID == null) || (refID.trim().length() == 0)) {
            return;
        }
        this.partyTypeRefDataServiceMap.remove(refID);
    }

    public Map<String, PartyTypeRef> getPartyTypeRefMap() {
        return this.partyTypeRefMap;
    }

    public Map<String, IPartyTypeRefDataService> getPartyTypeRefDataServiceMap() {
        return this.partyTypeRefDataServiceMap;
    }

    public PartyTypeTreeModel getPartyTypeTreeModel() {
        return this.partyTypeTreeModel;
    }

    public PartyTypeTreeModel getLoginPartyTypeTreeModel() {
        return this.loginPartyTypeTreeModel;
    }

    public static PartyTypeRefManager getInstance() {
        if (instance == null) {
            instance = new PartyTypeRefManager();
        }
        return instance;
    }
}
