package com.zimax.components.coframe.rights.mapper;

import com.zimax.components.coframe.rights.pojo.PartyAuth;
import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.components.coframe.rights.pojo.UserPartyAuthVo;
import com.zimax.components.coframe.rights.pojo.UserVo;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfo;
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
     List<UserVo> queryUsers(Map map);

     int count(@Param("userId") String userId, @Param("userName") String userName,
               @Param("roleNameList") String roleNameList, @Param("userType") String userType,
               @Param("status") String status, @Param("userCreator") String userCreator,
               @Param("userUpdater") String userUpdater

     );

//     /**
//      * 查询匹配密码的用户记录数,用户
//      */
//
//     int countPa(@Param("userId") String userId );
//
//     List<User> queryPassword(Map map);

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
      * 通过用户登录名查询到用户的角色类型
      *
      * @param userId 用户操作编号数组
      */

     List<UserPartyAuthVo> getRoleName(@Param("userId") String userId);

     /**
      * 批量删除用户分配权限信息
      */
     void deleteUsersAuth(String userId);

     /**
      * 获取用户
      */
     User getUser(int operatorId );

//     /**
//      * 重置密码
//      */
//     void updatePasswords(@Param("userIds") List<String> userIds,@Param("password")String password);

     /**
      * 重置密码
      */
     void updatePasswords(List<User> users);

     /**
      * 检查用户是否存在（添加）
      */
     int checkUser(@Param("userId") String userId);

     /**
      * 检查用户是否存在（编辑）
      */
     int checkUserEdit(@Param("userId") String userId,@Param("operatorId") String operatorId);

     /**
      * 获取用户
      */
     User getUserByUserId(String userId );


}
