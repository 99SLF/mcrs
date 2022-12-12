package com.zimax.components.coframe.rights.partyauth;

import com.zimax.cap.party.Party;
import com.zimax.components.coframe.rights.mapper.PartyAuthMapper;
import com.zimax.components.coframe.rights.pojo.PartyAuth;

import java.util.List;

/**
 * 默认的参与者授权管理
 *
 * @author 苏尚文
 * @date 2022/12/9 11:29
 */
public class DefaultPartyAuthManager {

    public final static String SPRING_BEAN_NAME = "DefaultPartyAuthManagerBean";

    private static String CAP_PARTYAUTH_ENTITY_ROLE_TYPE_PROPERTY = "roleType";

    private static String CAP_PARTYAUTH_ENTITY_PARTY_TYPE_PROPERTY = "partyId";

    private static String CAP_PARTYAUTH_ENTITY_PARTY_ID_PROPERTY = "partyType";

    private PartyAuthMapper partyAuthMapper;

    public PartyAuthMapper getPartyAuthMapper() {
        return partyAuthMapper;
    }

    public void setPartyAuthMapper(PartyAuthMapper partyAuthMapper) {
        this.partyAuthMapper = partyAuthMapper;
    }

    public void savePartyAuth(PartyAuth capPartyAuth) {
//        getDASTemplate().saveEntity(capPartyAuth);
    }

    public void deletePartyAuth(PartyAuth capPartyAuth) {
//        getDASTemplate().deleteEntity(capPartyAuth);
    }

    public void deletePartyAuthBatch(List<PartyAuth> partyAuths) {
        partyAuthMapper.deletePartyAuthBatch(partyAuths);
    }

    public void savePartyAuthBatch(List<PartyAuth> partyAuths) {
        partyAuthMapper.insertPartyAuthBatch(partyAuths);
    }

    public void insertAndDelete(List<PartyAuth> toAdd, List<PartyAuth> toDel) {
        if (toAdd != null && !toAdd.isEmpty()) {
            this.savePartyAuthBatch(toAdd);
        }
        if (toDel != null && !toDel.isEmpty()) {
            this.deletePartyAuthBatch(toDel);
        }
    }

    public int delPartyAuthByRole(Party roleParty) {
//        IDASCriteria criteria = DASManager.createCriteria(PartyAuth.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, roleParty.getTenantID()));
//        criteria.add(ExpressionHelper.eq(CAP_PARTYAUTH_ENTITY_ROLE_TYPE_PROPERTY, roleParty.getPartyTypeID()));
//        criteria.add(ExpressionHelper.eq("role.roleId", roleParty.getId()));
//        criteria.add(ExpressionHelper.eq("role.tenantId", roleParty.getTenantID()));
//        return getDASTemplate().deleteByCriteriaEntity(criteria);
        return 0;
    }

    public void deletePartyAuth(String partyId, String partyType, String tenantId) {
//        IDASCriteria criteria = DASManager.createCriteria(PartyAuth.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, tenantId));
//        criteria.add(ExpressionHelper.eq(CAP_PARTYAUTH_ENTITY_PARTY_ID_PROPERTY, partyId));
//        criteria.add(ExpressionHelper.eq(CAP_PARTYAUTH_ENTITY_PARTY_TYPE_PROPERTY, partyType));
//        getDASTemplate().deleteByCriteriaEntity(criteria);
    }

}
