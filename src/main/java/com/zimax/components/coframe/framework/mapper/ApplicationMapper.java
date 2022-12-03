package com.zimax.components.coframe.framework.mapper;

import com.zimax.components.coframe.framework.pojo.Application;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @Author 施林丰
 * @Date:2022/12/3 15:33
 * @Description
 */
@Mapper
public interface ApplicationMapper {
    public List<Application> queryRoles();
    public Application getRole(int id);
    public void addApplication(Application application);
    public void removeApplication(int applicationId);
    public void updateApplication(Application application);
}
