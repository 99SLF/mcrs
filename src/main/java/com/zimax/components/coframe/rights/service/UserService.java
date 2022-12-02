package com.zimax.components.coframe.rights.service;

import com.zimax.components.coframe.rights.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 角色服务
 */
@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 查询所有角色信息
     * @return
     */
  /*  public List<User> queryUsers(){
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        List<User> userList = userMapper.selectList(queryWrapper);
        System.out.println(userList.toString());
        return userList;*/


}
