package com.zimax.components.coframe.org.controller;

import com.zimax.components.coframe.framework.pojo.Application;
import com.zimax.components.coframe.framework.service.ApplicationService;
import com.zimax.components.coframe.org.pojo.Organization;
import com.zimax.components.coframe.org.pojo.vo.OrganizationDelVo;
import com.zimax.components.coframe.org.service.OrganizationService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author 施林丰
 * @Date:2023/2/9 9:41
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/org")
public class OrganizationController {
    @Autowired
    OrganizationService organizationService;

    /**
     * 查询组织机构
     *
     * @param parentOrgId 父机构Id
     * @param orgCode     机构代码
     * @param orgType     机构类型
     * @param limit       记录数
     * @param page        页码
     * @param field       排序字段
     * @param order       排序方式
     * @return 应用列表
     */
    @GetMapping("/Organization/queryOrg")
    public Result<?> queryOrg(String limit, String page, Integer parentOrgId, String orgCode, String orgType, String order, String field) {
        List organizations = organizationService.queryOrg(page, limit, parentOrgId, orgCode, orgType, order, field);
        return Result.success(organizations, organizationService.count(parentOrgId, orgCode, orgType));
    }

    /**
     * 新增机构
     *
     * @param organization 机构信息
     */
    @PostMapping("/Organization/addOrg")
    public Result<?> addOrg(@RequestBody Organization organization) {
        //addOrgapplicationService.addApplication(application);
        return Result.success();
    }

    /**
     * 删除机构
     *
     * @param appId 应用信息编号
     */
    @DeleteMapping("/Organization/deleteNodes")
    public Result<?> deleteNodes(@RequestBody int appId) {
        // applicationService.deleteApplication(appId);
        return Result.success();
    }

    /**
     * 更新机构
     *
     * @param organizationDelVo 删除机构信息
     */
    @PutMapping("/Organization/updateOrg")
    public Result<?> updateOrg(@RequestBody OrganizationDelVo organizationDelVo) {
        //applicationService.updateApplication(application);
        return Result.success();
    }


}
