package com.zimax.mcrs.rights.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zimax.mcrs.rights.pojo.Role;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 角色数据操作
 */
public interface RoleMapper {
    public List<Role> findAll();

}
