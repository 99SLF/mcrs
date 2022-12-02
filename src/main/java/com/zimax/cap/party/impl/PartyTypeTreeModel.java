package com.zimax.cap.party.impl;

import java.util.ArrayList;
import java.util.List;

/**
 * 参与者类型树模型
 *
 * @author 苏尚文
 * @date 2022/12/2 16:59
 */
public class PartyTypeTreeModel {

    private List<PartyTypeTreeNode> rootPartyTreeNodeList;

    public PartyTypeTreeModel() {
        this.rootPartyTreeNodeList = new ArrayList();
    }

    public List<PartyTypeTreeNode> getRootPartyTreeNode() {
        return this.rootPartyTreeNodeList;
    }

    public void addRootPartyTreeNode(PartyTypeTreeNode rootPartyTreeNode) {
        this.rootPartyTreeNodeList.add(rootPartyTreeNode);
    }

    public static class PartyTypeTreeNode {
        private String partyTypeID;
        private String partyTypeRefID;
        private boolean selfRelation;
        private String selfPartyTypeRefID;
        private PartyTypeTreeNode parentTypeTreeNode;
        private List<PartyTypeTreeNode> childrenTypeTreeNodeList = null;

        public PartyTypeTreeNode(String partyTypeID) {
            this.partyTypeID = partyTypeID;
        }

        public PartyTypeTreeNode(String partyTypeID,
                                 PartyTypeTreeNode parentTypeTreeNode) {
            this.partyTypeID = partyTypeID;
            this.parentTypeTreeNode = parentTypeTreeNode;
            parentTypeTreeNode.addChildrenTypeTreeNode(this);
        }

        public List<PartyTypeTreeNode> getChildrenTypeTreeNode() {
            return this.childrenTypeTreeNodeList;
        }

        public void addChildrenTypeTreeNode(
                PartyTypeTreeNode childrenTypeTreeNode) {
            if (this.childrenTypeTreeNodeList == null) {
                this.childrenTypeTreeNodeList = new ArrayList();
            }
            this.childrenTypeTreeNodeList.add(childrenTypeTreeNode);
        }

        public PartyTypeTreeNode getParentTypeTreeNode() {
            return this.parentTypeTreeNode;
        }

        public void setParentTypeTreeNode(PartyTypeTreeNode parentTypeTreeNode) {
            this.parentTypeTreeNode = parentTypeTreeNode;
        }

        public String getPartyTypeID() {
            return this.partyTypeID;
        }

        public void setPartyTypeID(String partyTypeID) {
            this.partyTypeID = partyTypeID;
        }

        public boolean isSelfRelation() {
            return this.selfRelation;
        }

        public void setSelfRelation(boolean selfRelation) {
            this.selfRelation = selfRelation;
        }

        public String getPartyTypeRefID() {
            return this.partyTypeRefID;
        }

        public void setPartyTypeRefID(String partyTypeRefID) {
            this.partyTypeRefID = partyTypeRefID;
        }

        public String getSelfPartyTypeRefID() {
            return this.selfPartyTypeRefID;
        }

        public void setSelfPartyTypeRefID(String selfPartyTypeRefID) {
            this.selfPartyTypeRefID = selfPartyTypeRefID;
        }
    }
}
