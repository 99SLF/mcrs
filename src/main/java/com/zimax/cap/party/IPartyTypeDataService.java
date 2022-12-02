package com.zimax.cap.party;

import java.util.List;

/**
 * 参与者类型数据服务接口
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public interface IPartyTypeDataService {

    /**
     * 获取所有的参与者列表
     *
     * @return 所有的参与者列表
     */
    List<Party> getAllPartyList();

    /**
     * 获取根参与者列表
     *
     * @return 根参与者列表
     */
    List<Party> getRootPartyList();

    /**
     * 根据参与者编号获取参与者
     *
     * @param partyId 参与者编号
     * @return 参与者
     */
    Party getPartyByPartyId(String partyId);
}
