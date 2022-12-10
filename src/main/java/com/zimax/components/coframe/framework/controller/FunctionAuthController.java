package com.zimax.components.coframe.framework.controller;

import com.zimax.components.coframe.framework.auth.FunctionAuthService;
import com.zimax.components.coframe.framework.pojo.Application;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import com.zimax.components.coframe.framework.pojo.Function;
import com.zimax.components.coframe.framework.pojo.FunctionAuth;
import com.zimax.components.coframe.framework.service.ApplicationService;
import com.zimax.components.coframe.framework.service.FuncGroupService;
import com.zimax.components.coframe.framework.service.FunctionService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date: 2022-12-1 15:21
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/function/auth")
public class FunctionAuthController {

    /**
     * 应用服务
     */
    @Autowired
    private ApplicationService applicationService;

    /**
     * 功能组服务
     */
    @Autowired
    private FuncGroupService funcGroupService;

    /**
     * 功能服务
     */
    @Autowired
    private FunctionService functionService;

    /**
     * 功能授权服务
     */
    @Autowired
    private FunctionAuthService functionAuthService;

    /**
     * 获取功能授权树
     *
     * @param roleId 角色编号
     * @return 功能授权树
     */
    @GetMapping("/tree/{roleId}")
    public Result<?> getFunctionAuthTree(@PathVariable("roleId") int roleId) {
        List<Application> applications = applicationService.queryAllApplications();
        List<FuncGroup> funcGroups = funcGroupService.queryAllFuncGroups();
        List<Function> functions = functionService.queryAllFunctionList();
        List<Map<String, Object>> applicationTree = applicationService.getApplicationTree(applications, funcGroups, functions);
        return Result.success(functionAuthService.getFunctionCheckedTree(applicationTree, String.valueOf(roleId)));
    }

    /**
     * 保存应用功能授权
     *
     * @param roleId 角色编号
     * @param functionAuths 应用功能授权
     * @return 是否成功
     */
    @PostMapping("/save/{roleId}")
    public Result<?> saveFunctionAuths(@PathVariable("roleId") int roleId, @RequestBody List<FunctionAuth> functionAuths) {
        return Result.success(functionAuthService.saveAuthFunctionsBatch(functionAuths, String.valueOf(roleId)));
    }

}
