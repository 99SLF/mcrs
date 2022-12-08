package com.zimax.components.coframe.auth.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * 用户初始化
 *
 * @author 苏尚文
 * @date 2022/12/8 16:27
 */
@Mapper
public interface UserInitMapper {

    /**
     * 查询用户基础信息
     *
     * @param userId
     * @return
     */
    List<Map> queryUserBaseInfo(String userId);

    // 查询参与者权限
    List<Map> queryPartyAuth(String userId);

}
