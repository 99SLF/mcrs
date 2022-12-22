package com.zimax.components.coframe.framework.service;

import com.zimax.components.coframe.framework.IFuncResourceService;
import com.zimax.components.coframe.framework.IFunctionService;
import com.zimax.components.coframe.framework.constants.IAppConstants;
import com.zimax.components.coframe.framework.mapper.ApplicationMapper;
import com.zimax.components.coframe.framework.pojo.Application;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import com.zimax.components.coframe.framework.pojo.Function;
import com.zimax.components.coframe.tools.IconCls;
import com.zimax.mcrs.config.ChangeString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
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
            map.put("field", "display_Order");
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
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        IFunctionService functionService = context.getBean("FunctionBean", IFunctionService.class);
        Function[] functions= functionService.getFunctionsByAppId((application.getAppId()));
        functionService.updateResoucesBatch(functions);
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

    /**
     * 查询所有的应用
     *
     * @return 所有的应用
     */
    public List<Application> queryAllApplications() {
        Map<String, Object> map = new HashMap<>();
        map.put("field", "display_order");
        map.put("order", "asc");
        return applicationMapper.queryApplications(map);
    }

    /**
     * 获取应用功能树
     */
    public List<Map<String, Object>> getApplicationTree(List<Application> applications, List<FuncGroup> funcGroups, List<Function> functions) {
        List<Map<String, Object>> treeList = new ArrayList<Map<String, Object>>();

        Map<String, Object> functionTreeMap = new HashMap<String, Object>();
        for (Application application : applications) {
            functionTreeMap.put(((Integer) application.getAppId()).toString(), IAppConstants.TYPE_APPLICATION + "_" + application.getAppId());
        }
        for (FuncGroup funcGroup : funcGroups) {
            functionTreeMap.put(((Integer) funcGroup.getFuncGroupId()).toString(), IAppConstants.TYPE_FUNCGROUP + "_" + funcGroup.getFuncGroupId());
        }

        // 构造应用树
        for (Application application : applications) {
            Map map = new HashMap();
            map.put("id", IAppConstants.TYPE_APPLICATION + "_" + application.getAppId());
            map.put("realId", application.getAppId());
            map.put("text", application.getAppName());
            map.put("type", IAppConstants.TYPE_APPLICATION);
            map.put("iconCls", IconCls.APPLICATION);
            treeList.add(map);
        }

        // 构造功能组树
        for (FuncGroup funcGroup : funcGroups) {
            Map map = new HashMap();
            map.put("id", IAppConstants.TYPE_FUNCGROUP + "_" + funcGroup.getFuncGroupId());
            map.put("realId", funcGroup.getFuncGroupId());
            map.put("text", funcGroup.getFuncGroupName());
            map.put("type", IAppConstants.TYPE_FUNCGROUP);
            String functionSeq = funcGroup.getFuncGroupSeq();
            String[] sequences = functionSeq.split("\\.");
            if (sequences.length > 2) {
                String parentId = sequences[sequences.length - 2];
                if (parentId != null && parentId.trim().length() > 0
                        && functionTreeMap.containsKey(parentId)) {
                    map.put("pid", functionTreeMap.get(parentId));
                } else {
                    map.put("pid", IAppConstants.TYPE_APPLICATION + "_" + funcGroup.getAppId());
                }
            } else {
                map.put("pid", IAppConstants.TYPE_APPLICATION + "_" + funcGroup.getAppId());
            }
            map.put("iconCls", IconCls.FUNCTION_GROUP_CLOSE);
            treeList.add(map);
        }
        // 构造functionTree
        for (Function function : functions) {
            Map map = new HashMap();
            map.put("id", IAppConstants.TYPE_FUNCTION + "_" + function.getFuncCode());
            map.put("realId", function.getFuncCode());
            map.put("text", function.getFuncName());
            map.put("type", IAppConstants.TYPE_FUNCTION);
            map.put("pid", IAppConstants.TYPE_FUNCGROUP + "_" + function.getFuncGroupId());
            map.put("iconCls", IconCls.MENU_ROOT);
            map.put(IAppConstants.FUNCTION_IS_CHECK, function.getIsCheck());
            treeList.add(map);
        }
        return treeList;
    }

}
