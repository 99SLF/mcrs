package com.zimax.cap.party;

import java.util.List;

/**
 * 参与者类型引用数据服务
 *
 * @author 苏尚文
 * @date 2022/12/2 17:34
 */
public interface IPartyTypeRefDataService {

    /**
     * 获取子参与者列表
     *
     * @param parentPartyId  父参与者编号
     * @return 子参与者列表
     */
    List<Party> getChildrenPartyList(String parentPartyId);

    /**
     * 获取父参与者列表
     *
     * @param childPartyId 子参与者编号
     * @return 父参与者列表
     */
    List<Party> getParentPartyList(String childPartyId);
}
