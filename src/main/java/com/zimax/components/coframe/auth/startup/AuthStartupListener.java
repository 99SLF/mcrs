package com.zimax.components.coframe.auth.startup;

import com.zimax.cap.auth.IAuthManagerService;
import com.zimax.cap.auth.manager.AuthManagerServiceLoader;
import com.zimax.cap.auth.manager.AuthRuntimeManager;
import com.zimax.cap.common.muo.MUODataContextHelper;
import com.zimax.cap.common.muo.VirtualUserObjectTypes;
import com.zimax.cap.management.resource.IMenuResourceManager;
import com.zimax.cap.management.resource.manager.ResourceConfigurationManager;
import com.zimax.cap.party.*;
import com.zimax.cap.party.manager.PartyManagerServiceLoader;
import com.zimax.cap.party.manager.PartyTypeManager;
import com.zimax.cap.party.manager.PartyTypeRefManager;
import com.zimax.cap.utility.StringUtil;
import com.zimax.components.coframe.auth.party.config.PartyModel;
import com.zimax.components.coframe.auth.party.config.PartyTypeModel;
import com.zimax.components.coframe.auth.party.config.PartyTypeRefModel;
import com.zimax.components.coframe.auth.service.AuthPartyRuntimeService;
import com.zimax.components.coframe.auth.service.IAuthPartyService;
import com.zimax.components.coframe.init.CoframePartyUserInitService;
import org.apache.log4j.Logger;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

/**
 * 组织权限管理启动监听器
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public class AuthStartupListener implements ServletContextListener {

    private static final Logger log = Logger.getLogger(AuthStartupListener.class);

    @Override
    public void contextInitialized(ServletContextEvent event) {
        MUODataContextHelper.getCustomMUO(VirtualUserObjectTypes.SERVER_USER);

        // 初始化，主要是为了让授权池作为监听器注册到可授权资源池
        AuthRuntimeManager.getInstance();

        PartyManagerServiceLoader
                .setCurrentPartyUserInitService(new CoframePartyUserInitService());

        // 提升登录性能，将角色资源映射加载出来
        List<Party> rolePartyList = AuthRuntimeManager.getInstance()
                .getAllRolePartyList();
        for (Party roleParty : rolePartyList) {
            AuthRuntimeManager.getInstance().getAuthResListByRole(roleParty);
        }

        loadPartyService(event);
        loadAuthService(event);
        loadPartyTypeConfig(event);
        loadMenuResourceModelConfig(event);
        loadPartyRoleAuthService(event);
    }

    // 加载party管理服务
    private void loadPartyService(ServletContextEvent event) {
        String service = "com.zimax.components.coframe.auth.party.DefaultPartyManagerService";
        if (StringUtil.isNotEmpty(service)) {
            try {
                Class clazz = AuthStartupListener.class.getClassLoader().loadClass(service);
                PartyManagerServiceLoader.setCurrentPartyManagerService((IPartyManagerService) clazz.newInstance());
            } catch (Throwable t) {
                log.error("loadPartyService[IPartyManagerService=" + service + "] error.", t);
            }
        }
    }

    // 加载auth管理服务
    private void loadAuthService(ServletContextEvent event) {
        String service = "com.zimax.components.coframe.auth.DefaultAuthManagerService";
        if (StringUtil.isNotEmpty(service)) {
            try {
                Class clazz = AuthStartupListener.class.getClassLoader().loadClass(service);
                AuthManagerServiceLoader.setCurrentPartyManagerService((IAuthManagerService) clazz.newInstance());
            } catch (Throwable t) {
                log.error("loadAuthService[IAuthManagerService=" + service + "] error.", t);
            }
        }
    }

    /**
     * 加载Party模型配置
     *
     * @param event
     *            监听事件对象
     */
    private void loadPartyTypeConfig(ServletContextEvent event) {
        PartyModel partyModel = new PartyModel();

        // role
        PartyTypeModel partyTypeModel = new PartyTypeModel();
        partyTypeModel.setTypeID("role");
        partyTypeModel.setName("角色");
        partyTypeModel.setPartyTypeDataService("com.zimax.components.coframe.auth.party.impl.RolePartyTypeDataService");
        partyTypeModel.setDescription("");
        partyTypeModel.setIsRole("true");
        partyTypeModel.setPriority("2");
        partyTypeModel.setIcon16("");
        partyTypeModel.setIcon32("");
        partyTypeModel.setShowInTree("true");
        partyTypeModel.setShowAtRoot("true");
        partyTypeModel.setIsLeaf("false");
        partyModel.addPartyTypeModel(partyTypeModel);

        // user
        partyTypeModel = new PartyTypeModel();
        partyTypeModel.setTypeID("user");
        partyTypeModel.setName("用户");
        partyTypeModel.setPartyTypeDataService("com.zimax.components.coframe.auth.party.impl.UserPartyTypeDataService");
        partyTypeModel.setDescription("");
        partyTypeModel.setIsRole("false");
        partyTypeModel.setPriority("6");
        partyTypeModel.setIcon16("");
        partyTypeModel.setIcon32("");
        partyTypeModel.setShowInTree("false");
        partyTypeModel.setShowAtRoot("false");
        partyTypeModel.setIsLeaf("true");
        partyModel.addPartyTypeModel(partyTypeModel);

        // role_user_ref
        PartyTypeRefModel partyTypeRefModel = new PartyTypeRefModel();
        partyTypeRefModel.setRefID("role_user_ref");
        partyTypeRefModel.setRefName("角色用户");
        partyTypeRefModel.setRefType("r_p");
        partyTypeRefModel.setParentPartyTypeID("role");
        partyTypeRefModel.setChildPartyTypeID("user");
        partyTypeRefModel.setPartyTypeRefDataService("com.zimax.components.coframe.auth.party.ref.impl.RoleUserRefDataService");
        partyModel.addPartyTypeRefModel(partyTypeRefModel);

        loadPartyModel(partyModel);
        loadPartyRefModel(partyModel);
    }

    /**
     * 加载Party模型
     *
     * @param partyModel
     *            参与者模型
     */
    private void loadPartyModel(PartyModel partyModel) {
        List<PartyTypeModel> partyTypeModelListList = partyModel.getPartyTypeModelList();
        for (PartyTypeModel partyTypeModel : partyTypeModelListList) {
            String typeID = partyTypeModel.getTypeID();

            PartyType partyType = new PartyType();
            partyType.setTypeId(typeID);
            partyType.setName(partyTypeModel.getName());
            partyType.setDescription(partyTypeModel.getDescription());
            String priority = partyTypeModel.getPriority();
            try {
                partyType.setPriority(Integer.parseInt(priority));
            } catch (Exception e) {
                partyType.setPriority(0);
            }

            if ("true".equals(partyTypeModel.getIsRole())) {
                partyType.setRole(true);
            }

            if ("true".equals(partyTypeModel.getShowInTree())) {
                partyType.setShowInTree(true);
            }

            partyType.setIcon16path(partyTypeModel.getIcon16());
            partyType.setIcon32path(partyTypeModel.getIcon32());
            if ("true".equals(partyTypeModel.getShowAtRoot())) {
                partyType.setShowAtRoot(true);
            }
            if ("true".equals(partyTypeModel.getIsLeaf())) {
                partyType.setLeaf(true);
            }
            Properties partyTypeExtProp = partyTypeModel.getExtProperties();
            Iterator it = partyTypeExtProp.keySet().iterator();
            while (it.hasNext()) {
                String key = (String) it.next();
                partyType.putExtAttribute(key,
                        partyTypeExtProp.getProperty(key));
            }
            PartyTypeManager.getInstance().putPartyType(typeID, partyType);

            String partyTypeDataServiceStr = partyTypeModel
                    .getPartyTypeDataService();
            if (StringUtil.isNotEmpty(partyTypeDataServiceStr)) {
                try {
                    Class clazz = AuthStartupListener.class
                            .getClassLoader()
                            .loadClass(partyTypeDataServiceStr);
                    PartyTypeManager
                            .getInstance()
                            .putPartyTypeDataService(typeID,
                                    (IPartyTypeDataService) clazz.newInstance());
                } catch (Throwable t) {
//                    log.error(
//                            "loadPartyModel[typeID={0}][IPartyTypeDataService={1}] error.",
//                            new Object[] { typeID, partyTypeDataServiceStr }, t);
                }
            }
        }
    }

    /**
     * 加载参与者引用模型
     *
     * @param partyModel
     *            参与者模型
     */
    private void loadPartyRefModel(PartyModel partyModel) {
        List<PartyTypeRefModel> partyTypeRefModelList = partyModel
                .getPartyTypeRefModelList();
        for (PartyTypeRefModel partyTypeRefModel : partyTypeRefModelList) {
            String refID = partyTypeRefModel.getRefID();
            PartyTypeRef partyTypeRef = new PartyTypeRef();
            partyTypeRef.setRefId(refID);
            partyTypeRef.setRefName(partyTypeRefModel.getRefName());

            String refType = partyTypeRefModel.getRefType();
            partyTypeRef.setRefType(refType);
            // 父子关系必须设置父子两个partyType属性
            String parentPartyTypeStr = partyTypeRefModel
                    .getParentPartyTypeID();
            String childPartyTypeStr = partyTypeRefModel.getChildPartyTypeID();
            PartyType parentPartyType = PartyTypeManager.getInstance()
                    .getPartyType(parentPartyTypeStr);
            PartyType childPartyType = PartyTypeManager.getInstance()
                    .getPartyType(childPartyTypeStr);
            partyTypeRef.setParentPartyType(parentPartyType);
            partyTypeRef.setChildPartyType(childPartyType);
            Properties partyTypeRefExtProp = partyTypeRefModel
                    .getExtProperties();
            Iterator it = partyTypeRefExtProp.keySet().iterator();
            while (it.hasNext()) {
                String key = (String) it.next();
                partyTypeRef.putExtAttribute(key,
                        partyTypeRefExtProp.getProperty(key));
            }
            PartyTypeRefManager.getInstance().putPartyTypeRef(refID,
                    partyTypeRef);
            String partyTypeRefDataServiceStr = partyTypeRefModel
                    .getPartyTypeRefDataService();
            if (StringUtil.isNotEmpty(partyTypeRefDataServiceStr)) {
                try {
                    Class clazz = AuthStartupListener.class
                            .getClassLoader().loadClass(
                                    partyTypeRefDataServiceStr);
                    PartyTypeRefManager.getInstance()
                            .putPartyTypeRefDataService(
                                    refID,
                                    (IPartyTypeRefDataService) clazz
                                            .newInstance());
                } catch (Throwable t) {
//                    log.error(
//                            "loadPartyRefModel[refID={0}][IPartyTypeRefDataService={1}] error.",
//                            new Object[] { refID, partyTypeRefDataServiceStr },
//                            t);
                }
            }

        }
        // 加载完成后形成组织机构树的模型
        PartyTypeRefManager.getInstance().calculatePartyTypeTreeModel();

        // party登录后，需要缓存相关party数据，那么需要一棵描述party的树模型，这个模型和组织机构树的区别在于：
        // 1. 组织机构树是参照partyType中是否根节点和是否子节点来形成树的，而此模型是以角色PartyType为单一的根向下延伸的
        // 2. 如果某个partyType没有和角色有直接或间接的关联，那么此partyType是不考虑的
        PartyTypeRefManager.getInstance().calculateLoginPartyTypeTreeModel();
    }

    // 加载菜单资源配置
    private void loadMenuResourceModelConfig(ServletContextEvent event) {
        String typeId = "function";
        String typeName = "功能";
        String menuResourceManager = "com.zimax.components.coframe.auth.menu.FunctionMenuResourceManager";
        ResourceConfigurationManager.getInstance().putResourceTypeName(
                typeId, typeName);
        if (StringUtil.isNotEmpty(menuResourceManager)) {
            try {
                Class clazz = AuthStartupListener.class
                        .getClassLoader().loadClass(menuResourceManager);
                ResourceConfigurationManager.getInstance()
                        .putMenuResourceManager(typeId,
                                (IMenuResourceManager) clazz.newInstance());
            } catch (Throwable t) {
//                    log.error(
//                            "loadMenuResourceModelConfig[typeId={0}][menuResourceManager={1}] error.",
//                            new Object[] { typeId, menuResourceManager }, t);
            }
        }
    }

    /**
     * 加载授权计算的接口
     *
     * @param event
     */
    private void loadPartyRoleAuthService(ServletContextEvent event) {
        // user
        String service = "com.zimax.components.coframe.auth.service.impl.UserAuthPartyService";
        if (StringUtil.isNotEmpty(service)) {
            try {
                Class clazz = AuthStartupListener.class
                        .getClassLoader().loadClass(service);
                AuthPartyRuntimeService.addAuthPartyService("user",(IAuthPartyService) clazz.newInstance());
            } catch (Throwable t) {
//                    log.error(
//                            "loadPartyAuthService[IAuthPartyService={0}] error.",
//                            new Object[] { service }, t);
            }
        }

        // emp
        service = "com.zimax.components.coframe.auth.service.impl.EmpAuthPartyService";
        if (StringUtil.isNotEmpty(service)) {
            try {
                Class clazz = AuthStartupListener.class
                        .getClassLoader().loadClass(service);
                AuthPartyRuntimeService.addAuthPartyService("emp",(IAuthPartyService) clazz.newInstance());
            } catch (Throwable t) {
//                    log.error(
//                            "loadPartyAuthService[IAuthPartyService={0}] error.",
//                            new Object[] { service }, t);
            }
        }

        // position
        service = "com.zimax.components.coframe.auth.service.impl.PositionAuthPartyService";
        if (StringUtil.isNotEmpty(service)) {
            try {
                Class clazz = AuthStartupListener.class
                        .getClassLoader().loadClass(service);
                AuthPartyRuntimeService.addAuthPartyService("position",(IAuthPartyService) clazz.newInstance());
            } catch (Throwable t) {
//                    log.error(
//                            "loadPartyAuthService[IAuthPartyService={0}] error.",
//                            new Object[] { service }, t);
            }
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }

}
