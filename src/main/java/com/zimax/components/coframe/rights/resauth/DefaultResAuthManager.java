package com.zimax.components.coframe.rights.resauth;

import com.zimax.cap.party.Party;
import com.zimax.components.coframe.rights.mapper.ResAuthMapper;
import com.zimax.components.coframe.rights.pojo.ResAuth;

import java.util.List;

/**
 * 默认的资源授权管理
 *
 * @author 苏尚文
 * @date 2022/12/9 10:05
 */
public class DefaultResAuthManager {

    public final static String SPRING_BEAN_NAME = "DefaultResAuthManagerBean";

    private static String CAP_RESAUTH_ENTITY_PARTY_ID_PROPERTY = "partyId";

    private static String CAP_RESAUTH_ENTITY_PARTY_TYPE_PROPERTY = "partyType";

    private static String CAP_RESAUTH_ENTITY_RES_TYPE_PROPERTY = "resType";

    private static String CAP_RESAUTH_ENTITY_RES_ID_PROPERTY = "resId";

    /**
     * 资源授权数据操作
     */
    private ResAuthMapper resAuthMapper;

    /**
     *
     */
    public DefaultResAuthManager() {
    }

    public ResAuthMapper getResAuthMapper() {
        return resAuthMapper;
    }

    public void setResAuthMapper(ResAuthMapper resAuthMapper) {
        this.resAuthMapper = resAuthMapper;
    }

    /**
     * 获取某个参与者对于某种类型资源的所有权限数据，目前参与者只支持角色参与者
     *
     * @param party 参与者
     * @param resType 资源类型
     * @return 资源授权集合
     */
    public ResAuth[] getResAuthListByResType(Party party, String resType) {
        List<ResAuth> resAuthList = resAuthMapper.getResAuthListByResType(party.getId(), party.getPartyTypeId(), resType);
        return resAuthList.toArray(new ResAuth[resAuthList.size()]);
    }

    public ResAuth getResAuthByResIdAndType(Party party, String resId, String resType) {
//        IDASCriteria criteria = DASManager.createCriteria(ResAuth.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, TenantManager.getCurrentTenantID()));
//        criteria.add(ExpressionHelper.eq(CAP_RESAUTH_ENTITY_PARTY_ID_PROPERTY, party.getId()));
//        criteria.add(ExpressionHelper.eq(CAP_RESAUTH_ENTITY_PARTY_TYPE_PROPERTY, party.getPartyTypeID()));
//        criteria.add(ExpressionHelper.eq(CAP_RESAUTH_ENTITY_RES_ID_PROPERTY, resId));
//        criteria.add(ExpressionHelper.eq(CAP_RESAUTH_ENTITY_RES_TYPE_PROPERTY, resType));
//        ResAuth[] ResAuths = getDASTemplate().queryEntitiesByCriteriaEntity(ResAuth.class, criteria);
//        if (ResAuths != null && ResAuths.length > 0) {
//            return ResAuths[0];
//        }
        return null;
    }

    public void updateResAuth(ResAuth capResauth) {
//        getDASTemplate().updateEntity(capResauth);
    }

    /**
     * 批量更新资源授权列表
     *
     * @param resAuths 资源授权列表
     */
    private void updateResAuthBatch(List<ResAuth> resAuths) {
        resAuthMapper.updateResAuthBatch(resAuths);
    }

    public void insertResAuth(ResAuth capResauth) {
//        getDASTemplate().insertEntity(capResauth);
    }

    /**
     * 批量插入资源授权列表
     *
     * @param resAuths 资源授权列表
     */
    private void insertResAuthBatch(List<ResAuth> resAuths) {
        resAuthMapper.insertResAuthBatch(resAuths);
    }

    public void deleteResAuth(ResAuth capResauth) {
//        IDASCriteria criteria = DASManager.createCriteria(ResAuth.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, TenantManager.getCurrentTenantID()));
//        criteria.add(ExpressionHelper.eq(CAP_RESAUTH_ENTITY_PARTY_ID_PROPERTY, capResauth.getPartyId()));
//        criteria.add(ExpressionHelper.eq(CAP_RESAUTH_ENTITY_PARTY_TYPE_PROPERTY, capResauth.getPartyType()));
//        criteria.add(ExpressionHelper.eq(CAP_RESAUTH_ENTITY_RES_ID_PROPERTY, capResauth.getResId()));
//        criteria.add(ExpressionHelper.eq(CAP_RESAUTH_ENTITY_RES_TYPE_PROPERTY, capResauth.getResType()));
//        getDASTemplate().deleteByCriteriaEntity(criteria);
    }

    /**
     * 批量删除资源授权列表
     *
     * @param resAuths 资源授权列表
     */
    private void deleteResAuthBatch(List<ResAuth> resAuths) {
        resAuthMapper.deleteResAuthBatch(resAuths);
    }

    /**
     * 保存资源授权
     *
     * @param toAdd 添加的资源授权
     * @param toUpdate 更新的资源授权
     * @param toDel 删除的资源授权
     */
    public void save(List<ResAuth> toAdd, List<ResAuth> toUpdate, List<ResAuth> toDel) {
        if (toAdd != null && !toAdd.isEmpty()) {
            this.insertResAuthBatch(toAdd);
        }
        if (toUpdate != null && !toUpdate.isEmpty()) {
            this.updateResAuthBatch(toUpdate);
        }
        if (toDel != null && !toDel.isEmpty()) {
            this.deleteResAuthBatch(toDel);
        }
    }

    /**
     * 根据参与者获取资源授权列表
     *
     * @param party 参与者
     * @return 资源授权列表
     */
    public ResAuth[] getResAuthListByParty(Party party) {
        List<ResAuth> resAuthList = resAuthMapper.getResAuthListByPartyIdAndPartyType(party.getId(), party.getPartyTypeId());
        return resAuthList.toArray(new ResAuth[resAuthList.size()]);
    }

    public int deleteResAuthByParty(Party party) {
//        IDASCriteria criteria = DASManager.createCriteria(ResAuth.QNAME);
//        criteria.add(ExpressionHelper.eq(IConstants.TENANT_PROPERTY, party.getTenantID()));
//        criteria.add(ExpressionHelper.eq(CAP_RESAUTH_ENTITY_PARTY_ID_PROPERTY, party.getId()));
//        criteria.add(ExpressionHelper.eq(CAP_RESAUTH_ENTITY_PARTY_TYPE_PROPERTY, party.getPartyTypeID()));
//        return getDASTemplate().deleteByCriteriaEntity(criteria);
        return 0;
    }
}