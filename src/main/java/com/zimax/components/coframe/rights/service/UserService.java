package com.zimax.components.coframe.rights.service;

import com.zimax.components.coframe.rights.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 李伟杰
 * @date 2022/12/3 9:49
 */
@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;
}
