package com.zimax.cap.party.impl;

import com.zimax.cap.party.*;
import com.zimax.cap.party.manager.PartyTypeManager;
import com.zimax.cap.party.manager.PartyTypeRefManager;
import com.zimax.cap.party.util.PartyUtil;
import org.apache.log4j.Logger;

import java.util.*;

/**
 * @author 苏尚文
 * @date 2022/12/2 17:03
 */
public class DefaultPartyManagerService extends AbstractPartyManagerService
        implements IPartyManagerService {

    private Logger log = Logger.getLogger(DefaultPartyManagerService.class);

    public int getOrder() {
        return 10000;
    }

    @Override
    public List<Party> doGetAllPartyList(String partyTypeID) {
        IPartyTypeDataService dataservice = PartyTypeManager.getInstance()
                .getPartyTypeDataService(partyTypeID);
        if (dataservice == null) {
            this.log.warn("Can not find the partyTypeDataservice for partyTypeID = "
                    + partyTypeID);
            return Collections.emptyList();
        }
        return dataservice.getAllPartyList();
    }

    @Override
    public List<Party> doGetRootPartyList(String partyTypeID) {
        IPartyTypeDataService dataservice = PartyTypeManager.getInstance()
                .getPartyTypeDataService(partyTypeID);
        if (dataservice == null) {
            this.log.warn("Can not find the partyTypeDataservice for partyTypeID = "
                    + partyTypeID);
            return Collections.emptyList();
        }
        return dataservice.getRootPartyList();
    }

    @Override
    public List<PartyType> doGetAllPartyTypeList() {
        Map<String, PartyType> map = PartyTypeManager.getInstance()
                .getPartyTypeMap();
        List<PartyType> partyTypeList = new ArrayList();
        Iterator<String> it = map.keySet().iterator();
        while (it.hasNext()) {
            String key = (String) it.next();
            partyTypeList.add(map.get(key));
        }
        Collections.sort(partyTypeList, PartyUtil.getPartyTypeComparator());
        return partyTypeList;
    }

    @Override
    public List<PartyTypeRef> doGetAllPartyTypeRefList() {
        Map<String, PartyTypeRef> map = PartyTypeRefManager.getInstance()
                .getPartyTypeRefMap();
        List<PartyTypeRef> partyTypeRefList = new ArrayList();
        Iterator<String> it = map.keySet().iterator();
        while (it.hasNext()) {
            String key = (String) it.next();
            partyTypeRefList.add(map.get(key));
        }
        return partyTypeRefList;
    }

    @Override
    public Map<String, List<Party>> doGetDirectAssociateChildPartyList(
            String parentPartyID, String parentPartyTypeID) {
        Map<String, PartyTypeRef> map = PartyTypeRefManager.getInstance()
                .getPartyTypeRefMap();
        Iterator<String> it = map.keySet().iterator();
        Map<String, List<Party>> returnMap = new HashMap();
        while (it.hasNext()) {
            String key = (String) it.next();
            PartyTypeRef partyTypeRef = (PartyTypeRef) map.get(key);
            if (parentPartyTypeID.equals(partyTypeRef.getParentPartyType()
                    .getTypeId())) {
                IPartyTypeRefDataService dataService = PartyTypeRefManager
                        .getInstance().getPartyTypeRefDataService(
                                partyTypeRef.getRefId());
                returnMap.put(partyTypeRef.getChildPartyType().getTypeId(),
                        dataService.getChildrenPartyList(parentPartyID));
            }
        }
        return returnMap;
    }

    @Override
    public Map<String, List<Party>> doGetDirectAssociateChildPartyList(
            String parentPartyID, String parentPartyTypeID,
            String[] childPartyTypes) {
        Map<String, PartyTypeRef> map = PartyTypeRefManager.getInstance()
                .getPartyTypeRefMap();
        Iterator<String> it = map.keySet().iterator();
        Map<String, List<Party>> returnMap = new HashMap();
        while (it.hasNext()) {
            String key = (String) it.next();
            PartyTypeRef partyTypeRef = (PartyTypeRef) map.get(key);
            if (parentPartyTypeID.equals(partyTypeRef.getParentPartyType()
                    .getTypeId())) {
                String childPartyTypeID = partyTypeRef.getChildPartyType()
                        .getTypeId();
                if (containObj(childPartyTypes, childPartyTypeID)) {
                    IPartyTypeRefDataService dataService = PartyTypeRefManager
                            .getInstance().getPartyTypeRefDataService(
                                    partyTypeRef.getRefId());
                    returnMap.put(childPartyTypeID, dataService
                            .getChildrenPartyList(parentPartyID));
                }
            }
        }
        return returnMap;
    }

    @Override
    public Map<String, List<Party>> doGetDirectAssociateChildPartyList(
            String parentPartyID, String[] partyTypeRefs) {
        Map<String, List<Party>> returnMap = new HashMap();
        for (String partyTypeRefID : partyTypeRefs) {
            IPartyTypeRefDataService dataService = PartyTypeRefManager
                    .getInstance().getPartyTypeRefDataService(partyTypeRefID);
            PartyType childPartyType = PartyTypeRefManager.getInstance()
                    .getPartyTypeRef(partyTypeRefID).getChildPartyType();
            returnMap.put(childPartyType.getTypeId(),
                    dataService.getChildrenPartyList(parentPartyID));
        }
        return returnMap;
    }

    @Override
    public Map<String, List<Party>> doGetDirectAssociateParentPartyList(
            String childPartyID, String childPartyTypeID) {
        Map<String, PartyTypeRef> map = PartyTypeRefManager.getInstance()
                .getPartyTypeRefMap();
        Iterator<String> it = map.keySet().iterator();
        Map<String, List<Party>> returnMap = new HashMap();
        while (it.hasNext()) {
            String key = (String) it.next();
            PartyTypeRef partyTypeRef = (PartyTypeRef) map.get(key);
            if (childPartyTypeID.equals(partyTypeRef.getChildPartyType()
                    .getTypeId())) {
                IPartyTypeRefDataService dataService = PartyTypeRefManager
                        .getInstance().getPartyTypeRefDataService(
                                partyTypeRef.getRefId());
                returnMap.put(partyTypeRef.getParentPartyType().getTypeId(),
                        dataService.getParentPartyList(childPartyID));
            }
        }
        return returnMap;
    }

    @Override
    public Map<String, List<Party>> doGetDirectAssociateParentPartyList(
            String childPartyID, String childPartyTypeID,
            String[] parentPartyTypes) {
        Map<String, PartyTypeRef> map = PartyTypeRefManager.getInstance()
                .getPartyTypeRefMap();
        Iterator<String> it = map.keySet().iterator();
        Map<String, List<Party>> returnMap = new HashMap();
        while (it.hasNext()) {
            String key = (String) it.next();
            PartyTypeRef partyTypeRef = (PartyTypeRef) map.get(key);
            if (childPartyTypeID.equals(partyTypeRef.getChildPartyType()
                    .getTypeId())) {
                String parentPartyTypeID = partyTypeRef.getParentPartyType()
                        .getTypeId();
                if (containObj(parentPartyTypes, parentPartyTypeID)) {
                    IPartyTypeRefDataService dataService = PartyTypeRefManager
                            .getInstance().getPartyTypeRefDataService(
                                    partyTypeRef.getRefId());
                    returnMap.put(parentPartyTypeID, dataService
                            .getParentPartyList(childPartyID));
                }
            }
        }
        return returnMap;
    }

    @Override
    public Map<String, List<Party>> doGetDirectAssociateParentPartyList(
            String childPartyID, String[] partyTypeRefs) {
        Map<String, List<Party>> returnMap = new HashMap();
        for (String partyTypeRefID : partyTypeRefs) {
            IPartyTypeRefDataService dataService = PartyTypeRefManager
                    .getInstance().getPartyTypeRefDataService(partyTypeRefID);
            PartyType parentPartyType = PartyTypeRefManager.getInstance()
                    .getPartyTypeRef(partyTypeRefID).getParentPartyType();
            returnMap.put(parentPartyType.getTypeId(),
                    dataService.getParentPartyList(childPartyID));
        }
        return returnMap;
    }

    @Override
    public Party doGetPartyByPartyId(String partyId, String partyType) {
        IPartyTypeDataService dataservice = PartyTypeManager.getInstance()
                .getPartyTypeDataService(partyType);
        if (dataservice != null) {
            return dataservice.getPartyByPartyId(partyId);
        }
        return null;
    }

    @Override
    public PartyType doGetPartyTypeByTypeID(String partyTypeID) {
        return PartyTypeManager.getInstance().getPartyType(partyTypeID);
    }

    @Override
    public PartyTypeRef doGetPartyTypeRefByRefID(String partyTypeRefID) {
        return PartyTypeRefManager.getInstance()
                .getPartyTypeRef(partyTypeRefID);
    }

    @Override
    public PartyTypeTreeModel doGetPartyTypeTreeModel() {
        return PartyTypeRefManager.getInstance().getPartyTypeTreeModel();
    }

    @Override
    public List<PartyType> doGetRootPartyTypeList() {
        List<PartyType> returnList = new ArrayList();
        PartyTypeTreeModel partyTypeTreeModel = getPartyTypeTreeModel();
        List<PartyTypeTreeModel.PartyTypeTreeNode> rootPartyTreeNodeList = partyTypeTreeModel
                .getRootPartyTreeNode();
        for (PartyTypeTreeModel.PartyTypeTreeNode partyTypeTreeNode : rootPartyTreeNodeList) {
            returnList.add(PartyTypeManager.getInstance().getPartyType(
                    partyTypeTreeNode.getPartyTypeID()));
        }
        return returnList;
    }

    @Override
    public PartyTypeTreeModel doGetLoginPartyTypeTreeModel() {
        return PartyTypeRefManager.getInstance().getLoginPartyTypeTreeModel();
    }

    @Override
    public Map<String, List<Party>> doGetLoginPartyCache(String partyID, String partyTypeID) {
        Map<String, List<Party>> returnMap = new HashMap();
        PartyTypeTreeModel loginPartyTreeModel = getLoginPartyTypeTreeModel();

        List<PartyTypeTreeModel.PartyTypeTreeNode> rootPartyTreeNodeList = loginPartyTreeModel
                .getRootPartyTreeNode();

        PartyTypeTreeModel.PartyTypeTreeNode rootPartyTypeTreeNode = (PartyTypeTreeModel.PartyTypeTreeNode) rootPartyTreeNodeList
                .get(0);

        List<PartyTypeTreeModel.PartyTypeTreeNode> partyTypeTreeNodeList = new ArrayList();
        if (rootPartyTypeTreeNode != null) {
            iteratorTree(partyTypeTreeNodeList, rootPartyTypeTreeNode,
                    partyTypeID);
        }
        for (PartyTypeTreeModel.PartyTypeTreeNode partyTypeTreeNode : partyTypeTreeNodeList) {
            iteratorAddPartyToMap(returnMap, partyTypeTreeNode,
                    getPartyByPartyID(partyID, partyTypeID));
        }
        return returnMap;
    }

    private void iteratorAddPartyToMap(Map<String, List<Party>> returnMap,
                                       PartyTypeTreeModel.PartyTypeTreeNode treeNode, Party party) {
        String partyTypeID = treeNode.getPartyTypeID();

        List<Party> partyList = (List) returnMap.get(partyTypeID);
        if (partyList == null) {
            partyList = new ArrayList();
            returnMap.put(partyTypeID, partyList);
        }
        if (!partyList.contains(party)) {
            partyList.add(party);
        }
        if (treeNode.isSelfRelation()) {
            String partyTypeRefID = treeNode.getSelfPartyTypeRefID();
            Map<String, List<Party>> parentPartyMap = getDirectAssociateParentPartyList(
                    party.getId(), new String[] { partyTypeRefID });
            List<Party> parentPartyList = (List) parentPartyMap
                    .get(partyTypeID);
            for (Party parentParty : parentPartyList) {
                iteratorAddPartyToMap(returnMap, treeNode, parentParty);
            }
        }
        PartyTypeTreeModel.PartyTypeTreeNode parentPartyTypeTreeNode = treeNode
                .getParentTypeTreeNode();
        if (parentPartyTypeTreeNode != null) {
            String partyTypeRefID = treeNode.getPartyTypeRefID();
            Map<String, List<Party>> parentPartyMap = getDirectAssociateParentPartyList(
                    party.getId(), new String[] { partyTypeRefID });

            List<Party> parentPartyList = (List) parentPartyMap
                    .get(getPartyTypeRefByRefID(partyTypeRefID)
                            .getParentPartyType().getTypeId());
            for (Party parentParty : parentPartyList) {
                iteratorAddPartyToMap(returnMap, parentPartyTypeTreeNode,
                        parentParty);
            }
        }
    }

    private void iteratorTree(
            List<PartyTypeTreeModel.PartyTypeTreeNode> partyTypeList,
            PartyTypeTreeModel.PartyTypeTreeNode partyTypeTreeNode,
            String partyTypeID) {
        if (partyTypeID.equals(partyTypeTreeNode.getPartyTypeID())) {
            partyTypeList.add(partyTypeTreeNode);
        } else {
            List<PartyTypeTreeModel.PartyTypeTreeNode> childrenPartyTypeTreeNodeList = partyTypeTreeNode
                    .getChildrenTypeTreeNode();
            if (childrenPartyTypeTreeNodeList != null) {
                for (PartyTypeTreeModel.PartyTypeTreeNode childPartyTypeTreeNode : childrenPartyTypeTreeNodeList) {
                    iteratorTree(partyTypeList, childPartyTypeTreeNode,
                            partyTypeID);
                }
            }
        }
    }

    private static boolean containObj(Object[] objs, Object obj) {
        for (Object tmp : objs) {
            if (tmp.equals(obj)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public Map<String, List<Party>> doGetAllParentPartyList(String partyID, String partyTypeID) {
        return null;
    }

    @Override
    public List<Party> doGetAssociatePartyList(String partyID, String partyTypeID, String associatePartyType) {
        return null;
    }

    @Override
    public Map<String, List<Party>> doGetScopePartyMap(String partyID, String partyTypeID) {
        return null;
    }

}
