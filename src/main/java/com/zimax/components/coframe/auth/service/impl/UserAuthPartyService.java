package com.zimax.components.coframe.auth.service.impl;

import com.zimax.components.coframe.tools.IConstants;

/**
 * 员工授权服务实现类，员工需要计算所有父节点
 *
 * @author 苏尚文
 * @date 2022/12/8 19:03
 */
public class UserAuthPartyService extends DefaultAuthPartyService {

    public UserAuthPartyService() {
        super(IConstants.USER_PARTY_TYPE_ID);
    }

    /**
     * 查询员工
     */
    public String[] getParentPartyTypes() {
        return new String[] { IConstants.EMP_PARTY_TYPE_ID };
    }

}
