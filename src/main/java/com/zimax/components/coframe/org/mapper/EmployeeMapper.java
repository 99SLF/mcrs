package com.zimax.components.coframe.org.mapper;

import com.zimax.components.coframe.org.pojo.Employee;
import org.apache.ibatis.annotations.Mapper;

/**
 * @Author 施林丰
 * @Date:2023/2/15 17:06
 * @Description
 */
@Mapper
public interface EmployeeMapper {
    Employee expandEntity(int empId);
}
