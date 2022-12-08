package com.zimax.components.coframe.framework.service;
import com.zimax.cap.management.resource.IManagedResource;
import com.zimax.cap.management.resource.impl.DefaultManagedResource;
import com.zimax.cap.management.resource.manager.ResourceRuntimeManager;
import com.zimax.components.coframe.framework.IFuncResourceService;
import com.zimax.components.coframe.framework.constants.IAppConstants;
import com.zimax.components.coframe.framework.mapper.ApplicationMapper;
import com.zimax.components.coframe.framework.mapper.FuncGroupMapper;
import com.zimax.components.coframe.framework.mapper.FuncResourceMapper;
import com.zimax.components.coframe.framework.mapper.FunctionMapper;
import com.zimax.components.coframe.framework.pojo.Application;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import com.zimax.components.coframe.framework.pojo.FuncResource;
import com.zimax.components.coframe.framework.pojo.Function;
import com.zimax.components.coframe.tools.IAuthConstants;
import org.apache.log4j.Logger;
import org.springframework.util.NumberUtils;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

/**
 * @Author 施林丰
 * @Date:2022/12/7 10:33
 * @Description
 */

    public class FuncResourceService implements IFuncResourceService {

        private Logger log = Logger.getLogger(FuncResourceService.class);

        private FuncResourceMapper funcResourceMapper;

        private FunctionMapper functionMapper;

        private FuncGroupMapper funcGroupMapper;

        private ApplicationMapper applicationMapper;

        public FuncResourceMapper getFuncResourceMapper() {
            return funcResourceMapper;
        }

        public void setFuncResourceMapper(FuncResourceMapper funcResourceMapper) {
            this.funcResourceMapper = funcResourceMapper;
        }

        public FunctionMapper getFunctionMapper() {
            return functionMapper;
        }

        public void setFunctionMapper(FunctionMapper functionMapper) {
            this.functionMapper = functionMapper;
        }

        public FuncGroupMapper getFuncGroupMapper() {
            return funcGroupMapper;
        }

        public void setFuncGroupMapper(FuncGroupMapper funcGroupMapper) {
            this.funcGroupMapper = funcGroupMapper;
        }

        public ApplicationMapper getApplicationMapper() {
            return applicationMapper;
        }

        public void setApplicationMapper(ApplicationMapper applicationMapper) {
            this.applicationMapper = applicationMapper;
        }

        @Override
        public void initFuncResources() {
            FuncResource[] funcResources = queryAllFuncResources();
            for (FuncResource funcResource : funcResources) {
                ResourceRuntimeManager.getInstance().registerManagedResource(adapt(funcResource));
            }
        }

        @Override
        public FuncResource[] queryAllFuncResources() {
            List<FuncResource> funcResourceList = funcResourceMapper.queryAllFuncResources();
            return funcResourceList.toArray(new FuncResource[funcResourceList.size()]);
        }

        public void addFuncResource(FuncResource Funcresource) {
//        getDASTemplate().getPrimaryKey(Funcresource);
//        Funcresource.setTenantId(TenantManager.getCurrentTenantID());
//        try {
//            getDASTemplate().insertEntity(Funcresource);
//            getDASTemplate().expandEntity(Funcresource);
//            ResourceRuntimeManager.getInstance().registerManagedResource(
//                    adapt(Funcresource));
//        } catch (Throwable t) {
//            log.error(
//                    "Insert funcResource [resName="
//                            + Funcresource.getResName()
//                            + "] failure, please do the operation again or contact the sysadmin.",
//                    t);
//        }
        }

        public void deleteFuncResource(FuncResource[] FuncResources) {
//        for (FuncResource Funcresource : FuncResources) {
//            try {
//                getDASTemplate().deleteEntityCascade(Funcresource);
//                ResourceRuntimeManager.getInstance().unRegisterManagedResource(
//                        Funcresource.getResName(),
//                        IAuthConstants.FUNCTION_TO_RESOURCE_TYPE);
//            } catch (Throwable t) {
//                log.error(
//                        "Delete funcResource [resName="
//                                + Funcresource.getResName()
//                                + "] failure, please do the operation again or contact the sysadmin.",
//                        t);
//            }
//        }
        }

        public void deleteFuncResourceByFuncCode(String funccode) {
//        FuncResource template = new FuncResourceImpl();
//        Function Function = new FunctionImpl();
//        Function.setFuncCode(funccode);
//        template.setFunction(Function);
//        getDASTemplate().deleteByTemplate(template);
//        IManagedResource managedResource = ResourceRuntimeManager.getInstance()
//                .getManagedResource(funccode,
//                        IAuthConstants.FUNCTION_TO_RESOURCE_TYPE);
//        List<IManagedResource> children = managedResource
//                .getChildren();
//        if (children != null) {
//            for (IManagedResource resource : children) {
//                try {
//                    ResourceRuntimeManager.getInstance()
//                            .unRegisterManagedResource(resource.getResourceID(),
//                                    IAuthConstants.FUNCTION_TO_RESOURCE_TYPE);
//                } catch (Throwable t) {
//                    log.error(
//                            "Delete funcResource [resName="
//                                    + resource.getResourceID()
//                                    + "] failure, please do the operation again or contact the sysadmin.",
//                            t);
//                }
//            }
//        }
        }

        public void getFuncResource(FuncResource Funcresource) {
//        getDASTemplate().expandEntity(Funcresource);
        }

//    public FuncResource[] queryFuncResources(CriteriaType criteriaType,
//                                             PageCond pageCond) {
//        IDASCriteria dasCriteria = getDASTemplate().criteriaTypeToDASCriteria(
//                criteriaType);
//        return getDASTemplate().queryEntitiesByCriteriaEntityWithPage(
//                FuncResource.class, dasCriteria, pageCond);
//    }

//    public FuncResource[] queryFuncResources(CriteriaType criteriaType) {
//        criteriaType.set_entity(FuncResource.QNAME);
//        IDASCriteria dasCriteria = getDASTemplate().criteriaTypeToDASCriteria(
//                criteriaType);
//        return getDASTemplate().queryEntitiesByCriteriaEntity(
//                FuncResource.class, dasCriteria);
//    }

        public void updateFuncResource(FuncResource Funcresource) {
//        try {
//            getDASTemplate().updateEntity(Funcresource);
//            getDASTemplate().expandEntity(Funcresource);
//            ResourceRuntimeManager.getInstance()
//                    .updateRegisteredManagedResource(adapt(Funcresource));
//        } catch (Throwable t) {
//            log.error(
//                    "Update funcresource [resName="
//                            + Funcresource.getResName()
//                            + "] failure, please do the operation again or contact the sysadmin.",
//                    t);
//        }
        }

//    public int countFuncResource(CriteriaType criteria) {
//        criteria.set_entity(FuncResource.QNAME);
//        IDASCriteria dasCriteria = getDASTemplate().criteriaTypeToDASCriteria(
//                criteria);
//        return getDASTemplate().count(dasCriteria);
//    }

        public void getPrimaryKey(FuncResource Funcresource) {
//        getDASTemplate().getPrimaryKey(Funcresource);
        }

        private IManagedResource adapt(FuncResource funcResource) {
            Function function = functionMapper.getFunction(funcResource.getFuncCode());
            IManagedResource parentManagedResource = ResourceRuntimeManager.getInstance().getManagedResource(
                    function.getFuncCode(), IAuthConstants.FUNCTION_TO_RESOURCE_TYPE);

            IManagedResource resource = new DefaultManagedResource(
                    parentManagedResource, funcResource.getResName(), funcResource.getResName(), IAuthConstants.FUNCTION_TO_STATES,
                    IAuthConstants.FUNCTION_TO_RESOURCE_TYPE, null, null, true);
            FuncGroup funcGroup = funcGroupMapper.getFuncGroup(function.getFuncGroupId());
            Application application = applicationMapper.getApplication(funcGroup.getAppId());
            if (application != null) {
                String appType = application.getAppType();
                String protocolType = application.getProtocolType();
                String ipAddr = application.getIpAddr();
                String ipPort = application.getIpPort();
                if (ipPort == null || "".equals(ipPort)) {
                    ipPort = "80";
                }
                String contextPath = application.getUrl();
                if ("1".equals(appType)) {
                    try {
                        URL url = new URL(protocolType, ipAddr,
                                NumberUtils.parseNumber(ipPort, Integer.class), contextPath);
                        resource.addAttribute(IAppConstants.APP_URL, url.toString());
                    } catch (MalformedURLException e) {
//                    log.error(
//                            "Get Appurl [appId="
//                                    + application.getAppId()
//                                    + "] failure, please do the operation again or contact the sysadmin.",
//                            e);
                    }
                }
            }
            // add app code
            resource.addAttribute(IAppConstants.APP_CODE, application.getAppCode());
            resource.addAttribute(IAppConstants.FUNCTION_IS_CHECK, function.getIsCheck());
            resource.addAttribute(IAppConstants.FUNCTION_PARA_INFO, function.getParaInfo());
            resource.addAttribute(IAppConstants.FUNCTION_URL, funcResource.getResPath());
            return resource;
        }
    }

