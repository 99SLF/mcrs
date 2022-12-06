package com.zimax.components.coframe.framework.mapper;

import com.zimax.components.coframe.framework.pojo.Application;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2022/12/3 15:33
 * @Description
 */
@Mapper
public interface ApplicationMapper {
    List<Application> queryApplications(Map map);
    Application getApplication(int id);
    void addApplication(Application application);
    void deleteApplication(int appId);
    void deleteApplications(List<Integer> appIds);
    void updateApplication(Application application);
}
