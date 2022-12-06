package com.zimax.components.coframe.rights.mapper;

import com.zimax.components.coframe.rights.pojo.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/3
 */
@Mapper
public interface UserMapper {
//     void addUser(User user);
     List<User> queryUsers(Map map);

}
