package com.zimax.components.coframe.rights.service;

import com.zimax.components.coframe.rights.mapper.UserMapper;
import com.zimax.components.coframe.rights.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/3
 */
@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

//    public void addUser(User user){
//        userMapper.addUser(user);
//    }

    /**
     * 查询所有用户信息
     */
    public List<User> queryUsers(int page, int limit, String status, String userName){
        System.out.println("success");
        Map<String,Object> map= new HashMap<>();
        map.put("begin", limit*(page-1));
        map.put("limit", limit);
        map.put("roleCode",status);
        map.put("roleName",userName);
        return userMapper.queryUsers(map);

    }
}
