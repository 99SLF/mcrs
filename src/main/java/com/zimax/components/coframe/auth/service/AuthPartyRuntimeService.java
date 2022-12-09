package com.zimax.components.coframe.auth.service;

import com.zimax.cap.party.Party;
import com.zimax.cap.party.manager.PartyRuntimeManager;
import com.zimax.components.coframe.auth.service.impl.DefaultAuthPartyService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 授权Party运行服务
 *
 * @author 苏尚文
 * @date 2022/12/8 18:22
 */
public class AuthPartyRuntimeService {

    private static final Map<String, IAuthPartyService> SERVICES = new HashMap<String, IAuthPartyService>();

    /**
     * 增加一种party类型的处理服务
     *
     * @param key
     * @param service
     */
    public static void addAuthPartyService(String key, IAuthPartyService service) {
        SERVICES.put(key, service);
    }

    public static IAuthPartyService getAuthPartyService(String key) {
        IAuthPartyService service = SERVICES.get(key);
        if (service == null) {
            service = new DefaultAuthPartyService(key);
        }
        return service;
    }

    /**
     * 获取可继承权限的party的列表,根据该类型展开权限计算层级，譬如用户关联操作员，岗位关联职位，机构无关联
     *
     * @param partyId
     * @param partyType
     * @return
     */
    public static List<Party> getAssociateAuthPartyList(String partyId,
                                                        String partyType) {
        return getAuthPartyService(partyType)
                .getAssociateAuthPartyList(partyId);
    }

    /**
     * 获取可继承权限的party的列表,根据该类型展开权限计算层级，譬如用户关联操作员，岗位关联职位，机构无关联
     *
     * @param partyId
     * @param partyType
     * @return
     */
    public static List<Party> getAssociateAuthRoles(String partyId,
                                                    String partyType) {
        return getAuthPartyService(partyType).getAssociateAuthRoles(partyId);
    }

    /**
     * 获取参与者的授权模型，包括参与者关联的所有party以及所有角色
     * @param partyId
     * @param partyType
     * @return
     */
    public static PartyAuthModel getPartyModel(String partyId, String partyType) {
        PartyAuthModel authModel = new PartyAuthModel();
        initAssociateAuthRoleList(partyId, partyType, authModel);
        return authModel;
    }

    private static void initAssociateAuthRoleList(String partyId,
                                                  String partyType, PartyAuthModel authModel) {
        List<Party> directPartyList = getAssociateAuthPartyList(partyId,
                partyType);
        Party currParty = PartyRuntimeManager.getInstance().getPartyByPartyID(
                partyId, partyType);
        if (currParty != null) {
            authModel.addParty(currParty);
            for (Party party : directPartyList) {
                initAssociateAuthRoleList(party.getId(),
                        party.getPartyTypeId(), authModel);
            }

            List<Party> directAuthRoleList = getAssociateAuthRoles(partyId,
                    partyType);
            for (Party party : directAuthRoleList) {
                authModel.addRoleparty(party);
            }
        }

    }

}
