package com.zimax.components.coframe.rights.mapper;

import com.zimax.components.coframe.rights.pojo.PartyAuth;
import com.zimax.components.coframe.rights.pojo.ResAuth;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 参与者授权数据操作
 *
 * @author 苏尚文
 * @date 2022/12/9 10:21
 */
@Mapper
public interface PartyAuthMapper {

    /**
     * 根据参与者编号和参与者类型获取资源授权列表
     *
     * @param partyId 参与者编号
     * @param partyType 参与者类型
     * @return 资源授权列表
     */
    List<ResAuth> getResAuthListByPartyIdAndPartyType(@Param("partyId") String partyId, @Param("partyType") String partyType);

    /**
     * 批量插入参与者授权列表
     *
     * @param partyAuths 参与者授权列表
     * @return 是否成功
     */
    void insertPartyAuthBatch(List<PartyAuth> partyAuths);

    /**
     * 批量删除参与者授权列表
     *
     * @param partyAuths 参与者授权列表
     */
    void deletePartyAuthBatch(List<PartyAuth> partyAuths);

}
