package com.zimax.components.coframe.auth.party;

import com.zimax.cap.party.*;
import com.zimax.cap.party.impl.PartyTypeTreeModel;
import com.zimax.cap.party.impl.PartyTypeTreeModel.PartyTypeTreeNode;
import com.zimax.cap.party.manager.PartyTypeManager;
import com.zimax.cap.party.manager.PartyTypeRefManager;
import com.zimax.cap.party.util.PartyUtil;
import com.zimax.components.coframe.auth.service.AuthPartyRuntimeService;
import com.zimax.components.coframe.auth.service.PartyAuthModel;
import org.apache.log4j.Logger;

import java.util.*;

/**
 * Party服务管理接口默认实现，使用默认配置文件及注册器进行相关数据计算，目前只是本地实现
 *
 * @author 苏尚文
 * @date 2022/12/8 18:08
 */
public class DefaultPartyManagerService extends AbstractPartyManagerService implements IPartyManagerService {

    private Logger log = Logger.getLogger(DefaultPartyManagerService.class);

    public int getOrder() {
        return 10000;
    }

    @Override
    public List<Party> doGetAllPartyList(String partyTypeId) {
        IPartyTypeDataService dataservice = PartyTypeManager.getInstance()
                .getPartyTypeDataService(partyTypeId);
        if (dataservice == null) {
            log.warn("Can not find the partyTypeDataservice for partyTypeID = "
                    + partyTypeId);
            return Collections.emptyList();
        }
        return dataservice.getAllPartyList();
    }

    @Override
    public List<Party> doGetRootPartyList(String partyTypeId) {
        IPartyTypeDataService dataservice = PartyTypeManager.getInstance()
                .getPartyTypeDataService(partyTypeId);
        if (dataservice == null) {
            log.warn("Can not find the partyTypeDataservice for partyTypeID = "
                    + partyTypeId);
            return Collections.emptyList();
        }
        return dataservice.getRootPartyList();
    }

    @Override
    public List<PartyType> doGetAllPartyTypeList() {
        Map<String, PartyType> map = PartyTypeManager.getInstance()
                .getPartyTypeMap();
        List<PartyType> partyTypeList = new ArrayList<PartyType>();
        Iterator<String> it = map.keySet().iterator();
        while (it.hasNext()) {
            String key = it.next();
            partyTypeList.add(map.get(key));
        }
        Collections.sort(partyTypeList, PartyUtil.getPartyTypeComparator());
        return partyTypeList;
    }

    @Override
    public List<PartyTypeRef> doGetAllPartyTypeRefList() {
        Map<String, PartyTypeRef> map = PartyTypeRefManager.getInstance()
                .getPartyTypeRefMap();
        List<PartyTypeRef> partyTypeRefList = new ArrayList<PartyTypeRef>();
        Iterator<String> it = map.keySet().iterator();
        while (it.hasNext()) {
            String key = it.next();
            partyTypeRefList.add(map.get(key));
        }
        return partyTypeRefList;
    }

    @Override
    public Map<String, List<Party>> doGetDirectAssociateChildPartyList(
            String parentPartyId, String parentPartyTypeId) {
        Map<String, PartyTypeRef> map = PartyTypeRefManager.getInstance()
                .getPartyTypeRefMap();
        Iterator<String> it = map.keySet().iterator();
        Map<String, List<Party>> returnMap = new HashMap<String, List<Party>>();

        while (it.hasNext()) {
            String key = it.next();
            PartyTypeRef partyTypeRef = map.get(key);
            if (parentPartyTypeId.equals(partyTypeRef.getParentPartyType()
                    .getTypeId())) {
                IPartyTypeRefDataService dataService = PartyTypeRefManager
                        .getInstance().getPartyTypeRefDataService(
                                partyTypeRef.getRefId());
                returnMap.put(partyTypeRef.getChildPartyType().getTypeId(),
                        dataService.getChildrenPartyList(parentPartyId));
            }
        }
        return returnMap;
    }

    @Override
    public Map<String, List<Party>> doGetDirectAssociateChildPartyList(
            String parentPartyId, String parentPartyTypeId,
            String[] childPartyTypes) {
        Map<String, PartyTypeRef> map = PartyTypeRefManager.getInstance()
                .getPartyTypeRefMap();
        Iterator<String> it = map.keySet().iterator();
        Map<String, List<Party>> returnMap = new HashMap<String, List<Party>>();

        while (it.hasNext()) {
            String key = it.next();
            PartyTypeRef partyTypeRef = map.get(key);
            if (parentPartyTypeId.equals(partyTypeRef.getParentPartyType()
                    .getTypeId())) {
                String childPartyTypeID = partyTypeRef.getChildPartyType()
                        .getTypeId();
                if (containObj(childPartyTypes, childPartyTypeID)) {
                    IPartyTypeRefDataService dataService = PartyTypeRefManager
                            .getInstance().getPartyTypeRefDataService(
                                    partyTypeRef.getRefId());
                    returnMap.put(childPartyTypeID, dataService
                            .getChildrenPartyList(parentPartyId));
                }
            }
        }
        return returnMap;
    }

    public Map<String, List<Party>> doGetDirectAssociateChildPartyList(
            String parentPartyId, String[] partyTypeRefs) {
        Map<String, List<Party>> returnMap = new HashMap<String, List<Party>>();

        for (String partyTypeRefID : partyTypeRefs) {
            IPartyTypeRefDataService dataService = PartyTypeRefManager
                    .getInstance().getPartyTypeRefDataService(partyTypeRefID);
            PartyType childPartyType = PartyTypeRefManager.getInstance()
                    .getPartyTypeRef(partyTypeRefID).getChildPartyType();
            returnMap.put(childPartyType.getTypeId(),
                    dataService.getChildrenPartyList(parentPartyId));
        }

        return returnMap;
    }

    @Override
    public Map<String, List<Party>> doGetDirectAssociateParentPartyList(
            String childPartyId, String childPartyTypeId) {
        Map<String, PartyTypeRef> map = PartyTypeRefManager.getInstance()
                .getPartyTypeRefMap();
        Iterator<String> it = map.keySet().iterator();
        Map<String, List<Party>> returnMap = new HashMap<String, List<Party>>();

        while (it.hasNext()) {
            String key = it.next();
            PartyTypeRef partyTypeRef = map.get(key);
            if (childPartyTypeId.equals(partyTypeRef.getChildPartyType()
                    .getTypeId())) {
                IPartyTypeRefDataService dataService = PartyTypeRefManager
                        .getInstance().getPartyTypeRefDataService(
                                partyTypeRef.getRefId());
                returnMap.put(partyTypeRef.getParentPartyType().getTypeId(),
                        dataService.getParentPartyList(childPartyId));
            }
        }
        return returnMap;
    }

    @Override
    public Map<String, List<Party>> doGetDirectAssociateParentPartyList(
            String childPartyId, String childPartyTypeId,
            String[] parentPartyTypes) {
        Map<String, PartyTypeRef> map = PartyTypeRefManager.getInstance()
                .getPartyTypeRefMap();
        Iterator<String> it = map.keySet().iterator();
        Map<String, List<Party>> returnMap = new HashMap<String, List<Party>>();

        while (it.hasNext()) {
            String key = it.next();
            PartyTypeRef partyTypeRef = map.get(key);
            if (childPartyTypeId.equals(partyTypeRef.getChildPartyType()
                    .getTypeId())) {
                String parentPartyTypeID = partyTypeRef.getParentPartyType()
                        .getTypeId();
                if (containObj(parentPartyTypes, parentPartyTypeID)) {
                    IPartyTypeRefDataService dataService = PartyTypeRefManager
                            .getInstance().getPartyTypeRefDataService(
                                    partyTypeRef.getRefId());
                    returnMap.put(parentPartyTypeID, dataService
                            .getParentPartyList(childPartyId));
                }
            }
        }
        return returnMap;
    }

    public Map<String, List<Party>> doGetDirectAssociateParentPartyList(
            String childPartyId, String[] partyTypeRefs) {
        Map<String, List<Party>> returnMap = new HashMap<String, List<Party>>();

        for (String partyTypeRefID : partyTypeRefs) {
            IPartyTypeRefDataService dataService = PartyTypeRefManager
                    .getInstance().getPartyTypeRefDataService(partyTypeRefID);
            PartyType parentPartyType = PartyTypeRefManager.getInstance()
                    .getPartyTypeRef(partyTypeRefID).getParentPartyType();
            returnMap.put(parentPartyType.getTypeId(), dataService.getParentPartyList(childPartyId));
        }

        return returnMap;
    }

    @Override
    public Party doGetPartyByPartyID(String partyID, String partyType) {
        IPartyTypeDataService dataservice = PartyTypeManager.getInstance()
                .getPartyTypeDataService(partyType);
        if (dataservice != null) {
            return dataservice.getPartyByPartyId(partyID);
        }
        return null;
    }

    @Override
    public PartyType doGetPartyTypeByTypeID(String partyTypeId) {
        return PartyTypeManager.getInstance().getPartyType(partyTypeId);
    }

    @Override
    public PartyTypeRef doGetPartyTypeRefByRefID(String partyTypeRefId) {
        return PartyTypeRefManager.getInstance().getPartyTypeRef(partyTypeRefId);
    }

    @Override
    public PartyTypeTreeModel doGetPartyTypeTreeModel() {
        return PartyTypeRefManager.getInstance().getPartyTypeTreeModel();
    }

    @Override
    public List<PartyType> doGetRootPartyTypeList() {
        List<PartyType> returnList = new ArrayList<PartyType>();
        PartyTypeTreeModel partyTypeTreeModel = this.getPartyTypeTreeModel();
        List<PartyTypeTreeNode> rootPartyTreeNodeList = partyTypeTreeModel
                .getRootPartyTreeNode();
        for (PartyTypeTreeNode partyTypeTreeNode : rootPartyTreeNodeList) {
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
    public Map<String, List<Party>> doGetLoginPartyCache(String partyId, String partyTypeId) {
        Map<String, List<Party>> returnMap = new HashMap<String, List<Party>>();
        PartyTypeTreeModel loginPartyTreeModel = this
                .getLoginPartyTypeTreeModel();
        // 从树模型中找到具体的partyType，然后向上查找到角色，每层都party相关数据都需要缓存
        List<PartyTypeTreeNode> rootPartyTreeNodeList = loginPartyTreeModel
                .getRootPartyTreeNode();
        // 只会有一个根
        PartyTypeTreeNode rootPartyTypeTreeNode = rootPartyTreeNodeList.get(0);
        // 用于存放所有的符合条件的树节点
        List<PartyTypeTreeNode> partyTypeTreeNodeList = new ArrayList<PartyTypeTreeNode>();
        if (rootPartyTypeTreeNode != null) {
            iteratorTree(partyTypeTreeNodeList, rootPartyTypeTreeNode,
                    partyTypeId);
        }

        for (PartyTypeTreeNode partyTypeTreeNode : partyTypeTreeNodeList) {
            iteratorAddPartyToMap(returnMap, partyTypeTreeNode,
                    this.getPartyByPartyID(partyId, partyTypeId));
        }

        return returnMap;
    }

    private void iteratorAddPartyToMap(Map<String, List<Party>> returnMap,
                                       PartyTypeTreeNode treeNode, Party party) {
        String partyTypeID = treeNode.getPartyTypeID();

        List<Party> partyList = returnMap.get(partyTypeID);
        if (partyList == null) {
            partyList = new ArrayList<Party>();
            returnMap.put(partyTypeID, partyList);
        }
        if (!partyList.contains(party)) {
            partyList.add(party);
        }

        if (treeNode.isSelfRelation()) {
            String partyTypeRefID = treeNode.getSelfPartyTypeRefID();
            Map<String, List<Party>> parentPartyMap = this
                    .getDirectAssociateParentPartyList(party.getId(),
                            new String[] { partyTypeRefID });
            List<Party> parentPartyList = parentPartyMap.get(partyTypeID);
            for (Party parentParty : parentPartyList) {
                iteratorAddPartyToMap(returnMap, treeNode, parentParty);
            }
        }
        PartyTypeTreeNode parentPartyTypeTreeNode = treeNode
                .getParentTypeTreeNode();
        if (parentPartyTypeTreeNode != null) {
            String partyTypeRefID = treeNode.getPartyTypeRefID();
            Map<String, List<Party>> parentPartyMap = this
                    .getDirectAssociateParentPartyList(party.getId(),
                            new String[] { partyTypeRefID });
            List<Party> parentPartyList = parentPartyMap.get(this
                    .getPartyTypeRefByRefID(partyTypeRefID)
                    .getParentPartyType().getTypeId());
            for (Party parentParty : parentPartyList) {
                iteratorAddPartyToMap(returnMap, parentPartyTypeTreeNode,
                        parentParty);
            }
        }

    }

    private void iteratorTree(List<PartyTypeTreeNode> partyTypeList,
                              PartyTypeTreeNode partyTypeTreeNode, String partyTypeID) {
        if (partyTypeID.equals(partyTypeTreeNode.getPartyTypeID())) {
            partyTypeList.add(partyTypeTreeNode);
        } else {
            List<PartyTypeTreeNode> childrenPartyTypeTreeNodeList = partyTypeTreeNode
                    .getChildrenTypeTreeNode();
            if (childrenPartyTypeTreeNodeList != null) {
                for (PartyTypeTreeNode childPartyTypeTreeNode : childrenPartyTypeTreeNodeList) {
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
    public Map<String, List<Party>> doGetAllParentPartyList(String partyId, String partyTypeId) {
        PartyAuthModel authModel = AuthPartyRuntimeService.getPartyModel(
                partyId, partyTypeId);
        Map<String, List<Party>> partyTypeListMap = new HashMap<String, List<Party>>();

        if (authModel.getPartys() != null) {
            for (Party party : authModel.getPartys()) {
                List<Party> partyList = partyTypeListMap.get(party
                        .getPartyTypeId());
                if (partyList == null) {
                    partyList = new ArrayList<Party>();
                    partyTypeListMap.put(party.getPartyTypeId(), partyList);
                }
                partyList.add(party);
            }
        }
        if (authModel.getRoles() != null) {
            for (Party party : authModel.getRoles()) {
                List<Party> partyList = partyTypeListMap.get(party
                        .getPartyTypeId());
                if (partyList == null) {
                    partyList = new ArrayList<Party>();
                    partyTypeListMap.put(party.getPartyTypeId(), partyList);
                }
                partyList.add(party);
            }
        }
        return partyTypeListMap;
    }

    @Override
    public List<Party> doGetAssociatePartyList(String partyId, String partyTypeId, String associatePartyType) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public Map<String, List<Party>> doGetScopePartyMap(String partyId, String partyTypeId) {
        // TODO 该处需要重构，用了很多实现中的方法
        return null;
    }

}