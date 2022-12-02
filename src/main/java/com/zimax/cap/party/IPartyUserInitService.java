package com.zimax.cap.party;

/**
 * 参与者用户初始化服务接口
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public interface IPartyUserInitService {

    /**
     * 初始化用户对象
     *
     * @param userId 用户名
     * @return 用户对象
     */
    IUserObject initUserObject(String userId);

}
