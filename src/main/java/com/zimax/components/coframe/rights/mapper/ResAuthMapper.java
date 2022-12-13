package com.zimax.components.coframe.rights.mapper;

import com.zimax.components.coframe.rights.pojo.ResAuth;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 资源授权数据操作
 *
 * @author 苏尚文
 * @date 2022/12/9 10:21
 */
@Mapper
public interface ResAuthMapper {

    /**
     * 根据参与者编号和参与者类型获取资源授权列表
     *
     * @param partyId 参与者编号
     * @param partyType 参与者类型
     * @return 资源授权列表
     */
    List<ResAuth> getResAuthListByPartyIdAndPartyType(@Param("partyId") String partyId, @Param("partyType") String partyType);

    /**
     * 获取资源授权列表
     *
     * @param partyId 参与者编号
     * @param partyType 参与者类型
     * @param resType 资源类型
     * @return
     */
    List<ResAuth> getResAuthListByResType(@Param("partyId") String partyId, @Param("partyType") String partyType, @Param("resType") String resType);

    /**
     * 批量插入资源授权列表
     *
     * @param resAuths 资源授权列表
     * @return 是否成功
     */
    void insertResAuthBatch(List<ResAuth> resAuths);

    /**
     * 批量更新资源授权列表
     *
     * @param resAuths 资源授权列表
     */
    void updateResAuthBatch(List<ResAuth> resAuths);

    /**
     * 批量删除资源授权列表
     *
     * @param resAuths 资源授权列表
     */
    void deleteResAuthBatch(List<ResAuth> resAuths);

    int countRoleResRelation(@Param("partyId") int partyId, @Param("partyType") String partyType);

    void deleteRoleResRelation(@Param("partyId") int partyId, @Param("partyType") String partyType);

}
