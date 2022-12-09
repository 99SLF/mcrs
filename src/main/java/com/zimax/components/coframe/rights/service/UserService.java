package com.zimax.components.coframe.rights.service;

import com.alibaba.excel.util.StringUtils;
import com.zimax.components.coframe.rights.mapper.UserMapper;
import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.mcrs.config.ChangeString;
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

    /**
     * 添加用户信息
     *
     * @param user 用户
     */
    public void addUser(User user) {
        userMapper.addUser(user);
    }

    public int count(String status, String userName) {
        return userMapper.count(status,userName);
    }

    /**
     * 查询所有用户信息
     */
    public List<User> queryUsers(int page, int limit, String status, String userName, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "create_time");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        map.put("begin", limit * (page - 1));
        map.put("limit", limit);
        map.put("status", status);
        map.put("userName", userName);
        return userMapper.queryUsers(map);

    }

    /**
     * 编辑，更新用户
     *
     */
    public  void updateUser(User user){
        userMapper.updateUser(user);
    }

    /**
     * 主键删除用户信息
     */
    public void deleteUser(int operatorId) {
        userMapper.deleteUser(operatorId);
    }

    /**
     * 批量删除用户
     * @param operatorIds 操作员编号
     */
    public void deleteUsers (List<Integer> operatorIds) {
        userMapper.deleteUsers(operatorIds);
    }
    /**
     * 根据操作员编号获取用户
     * @param operatorId 操作员编号
     */
    public User getUser(int operatorId){
        return userMapper.getUser(operatorId);
    }

    /**
     * 重置密码
     * @param operatorIds 操作员编号
     */
    public void changePassword (List<Integer> operatorIds) {
        userMapper.changePassword(operatorIds);
    }

    /**
     * 获取用户
     * @param userId 用户编号
     */
    public User checkUser(String userId){
        return userMapper.checkUser(userId);
    }
    /**
     * 获取用户
     * @param userId 用户编号
     */
    public User getUserByUserId(String userId) {
        if (!StringUtils.isBlank(userId)) {
            User user = userMapper.getUserByUserId(userId);
           // return users.length > 0 ? users[0] : null;
        }
        return null;
    }
}
