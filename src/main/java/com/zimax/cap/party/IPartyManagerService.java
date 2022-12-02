package com.zimax.cap.party;

import com.zimax.cap.party.impl.PartyTypeTreeModel;

import java.util.List;
import java.util.Map;

/**
 * 参与者管理服务接口
 *
 * @author 苏尚文
 * @date 2022/12/2 16:55
 */
public interface IPartyManagerService {

    Party getPartyByPartyID(String paramString1,
                                            String paramString2);

    List<PartyType> getAllPartyTypeList();

    List<PartyTypeRef> getAllPartyTypeRefList();

    PartyType getPartyTypeByTypeID(String paramString);

    PartyTypeRef getPartyTypeRefByRefID(String paramString);

    List<Party> getAllPartyList(String paramString);

    Map<String, List<Party>> getDirectAssociateChildPartyList(
            String paramString1, String paramString2);

    Map<String, List<Party>> getDirectAssociateChildPartyList(
            String paramString1, String paramString2,
            String[] paramArrayOfString);

    Map<String, List<Party>> getDirectAssociateChildPartyList(
            String paramString, String[] paramArrayOfString);

    Map<String, List<Party>> getDirectAssociateParentPartyList(
            String paramString1, String paramString2);

    Map<String, List<Party>> getDirectAssociateParentPartyList(
            String paramString1, String paramString2,
            String[] paramArrayOfString);

    Map<String, List<Party>> getDirectAssociateParentPartyList(
            String paramString, String[] paramArrayOfString);

    PartyTypeTreeModel getPartyTypeTreeModel();

    List<PartyType> getRootPartyTypeList();

    PartyTypeTreeModel getLoginPartyTypeTreeModel();

    /**
     * @deprecated
     */
    Map<String, List<Party>> getLoginPartyCache(
            String paramString1, String paramString2);

    List<Party> getRootPartyList(String paramString);

    Map<String, List<Party>> getAllParentPartyList(
            String paramString1, String paramString2);

    Map<String, List<Party>> getScopePartyMap(
            String paramString1, String paramString2);

    List<Party> getAssociatePartyList(
            String paramString1, String paramString2, String paramString3);

}