package com.zimax.components.coframe.framework.service;

import com.zimax.components.coframe.framework.mapper.ApplicationMapper;
import com.zimax.components.coframe.framework.pojo.Application;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import com.zimax.components.coframe.framework.pojo.Function;
import com.zimax.mcrs.config.ChangeString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2022/12/6 11:30
 * @Description
 */
@Service
public class ApplicationService {
    /**
     * 应用信息数据操作
     */
    @Autowired
    private ApplicationMapper applicationMapper;
    @Autowired
    private FuncGroupService funcGroupService;

    /**
     * 查询所有应用信息
     *
     * @return
     */
    public List<Application> queryApplications(String page, String limit, String appName, String appType, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "app_id");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("appName", appName);
        map.put("appType", appType);
        return applicationMapper.queryApplications(map);
    }

    /**
     * 添加应用信息
     *
     * @param application 应用
     */
    public void addApplication(Application application) {
        applicationMapper.addApplication(application);
    }

    /**
     * 根绝应用编号删除
     *
     * @param appId 应用编号
     */
    public void deleteApplication(int appId) {
        applicationMapper.deleteApplication(appId);

    }

    /**
     * 更新应用
     *
     * @param application 应用信息
     */
    public void updateApplication(Application application) {
        applicationMapper.updateApplication(application);
    }

    /**
     * 根绝应用编码查询
     *
     * @param appId 应用编号
     */
    public Application getApplication(int appId) {
        return applicationMapper.getApplication(appId);
    }

    /**
     * 批量删除应用
     *
     * @param appIds 应用编号集合
     */
    public void deleteApplications(List<Integer> appIds) {
        for (int i = 0; i < appIds.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            map.put("appId", appIds.get(i));
            List<FuncGroup> funcGroups = funcGroupService.getFuncGroupMapper().queryFuncGroups(map);
            List<Integer> funcGroupIds = new ArrayList<>();
            for (FuncGroup funcGroup : funcGroups) {
                funcGroupIds.add(funcGroup.getFuncGroupId());
            }
            if(funcGroupIds.size()!=0){
                funcGroupService.deletefuncGroups(funcGroupIds);
            }
        }
        applicationMapper.deleteApplications(appIds);
    }

    /**
     * 查询记录
     */
    public int count(String appName, String appType) {
        return applicationMapper.count(appName, appType);
    }

}
