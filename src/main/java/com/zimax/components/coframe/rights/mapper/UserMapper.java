package com.zimax.components.coframe.rights.mapper;

import com.zimax.components.coframe.rights.pojo.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/3
 */
@Mapper
public interface UserMapper {

     /**
      * 添加用户
      */
     void addUser(User user);

     /**
      * 查询所有用户
      */
     List<User> queryUsers(Map map);

     int count(@Param("status") String status, @Param("userName") String userName);

     /**
      * 更新用户
      */
     void updateUser(User user);

     /**
      * 主键删除用户
      */
      void deleteUser(int operatorId);

     /**
      * 批量删除用户
      */
     void deleteUsers(List<Integer> operatorIds);

     /**
      * 获取用户
      */
     User getUser(int operatorId );

     /**
      * 重置密码
      */
     void changePassword(List<Integer> operatorIds);

     /**
      * 检查用户是否存在
      */
     User checkUser(String userId );

     /**
      * 获取用户
      */
     User getUserByUserId(String userId );

}
