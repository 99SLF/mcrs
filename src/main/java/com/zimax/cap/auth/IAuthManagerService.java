package com.zimax.cap.auth;

import com.zimax.cap.party.Party;

import java.util.List;

/**
 * 授权管理服务
 *
 * @author 苏尚文
 * @date 2022/12/2 15:21
 */
public interface IAuthManagerService {

    int DEL_MODE_SINGLE = 0;

    int DEL_MODE_COMPLEX = 1;

    /**
     * 根据角色参与者获取授权资源列表
     *
     * @param party 角色参与者
     * @return 授权资源列表
     */
    List<AuthResource> getAuthResListByRole(Party party);

    boolean addOrUpdateAuthRes(Party paramParty,
                               AuthResource paramAuthResource);

    boolean addOrUpdateAuthResBatch(Party paramParty,
                                    List<AuthResource> paramList);

    boolean delAuthRes(Party paramParty,
                       AuthResource paramAuthResource, int paramInt);

    /**
     *  批量删除授权资源
     *
     * @param party 参与者
     * @param authResList 授权资源列表
     * @param mode 模式
     * @return 是否成功
     */
    boolean delAuthResBatch(Party party, List<AuthResource> authResList, int mode);

    boolean addOrUpdatePartyAuth(Party paramParty1,
                                 Party paramParty2);

    boolean addOrUpdatePartyAuthBatch(Party paramParty,
                                      List<Party> paramList);

    boolean addOrUpdatePartyAuthBatch(List<Party> paramList,
                                      Party paramParty);

    boolean delPartyAuth(Party paramParty1, Party paramParty2,
                         int paramInt);

    boolean delPartyAuthBatch(Party paramParty,
                              List<Party> paramList, int paramInt);

    boolean delPartyAuthBatch(List<Party> paramList,
                              Party paramParty, int paramInt);

    boolean delPartyAuthByRole(Party paramParty);

    boolean delAuthResByRole(Party paramParty);

    boolean deletePartyAuth(String paramString1,
                            String paramString2);

    MenuTree getUserMenuTree();

    MenuTree getUserMenuTreeByAppCode(String paramString);

    MenuTree getUserMenuTree(
            IMenuTreeFilter paramIMenuTreeFilter);

    interface IMenuTreeFilter {

        MenuTree doFilter(MenuTree paramMenuTree);

    }
}
