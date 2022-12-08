package com.zimax.components.coframe.init;

import com.zimax.components.coframe.auth.mapper.UserInitMapper;

import java.util.List;
import java.util.Map;

/**
 * 用户登录初始化查询用户及权限信息
 *
 * @author 苏尚文
 * @date 2022/12/8 15:53
 */
public class InitUserObjectService {

    public static String SPRING_BEAN_NAME = "InitUserObjectServiceBean";

    private UserInitMapper userInitMapper;

    /**
     * 查询用户信息
     *
     * @param userId
     * @return 用户属于多机构时，会返回多条数据
     */
    public Map[] getUserBaseInfo(String userId) {
        List<Map> resultList = userInitMapper.queryUserBaseInfo(userId);
        return resultList.toArray(new Map[resultList.size()]);
    }

    /**
     * 查询用户的权限
     *
     * @param userId
     * @return 返回多条数据
     */
    public Map[] getUserPartyAuth(String userId) {
        List<Map> resultList = userInitMapper.queryPartyAuth(userId);
        return resultList.toArray(new Map[resultList.size()]);
    }

    public UserInitMapper getUserInitMapper() {
        return userInitMapper;
    }

    public void setUserInitMapper(UserInitMapper userInitMapper) {
        this.userInitMapper = userInitMapper;
    }

}
