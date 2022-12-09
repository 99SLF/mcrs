package com.zimax.components.coframe.init;
import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.datacontext.IMUODataContext;
import com.zimax.cap.datacontext.ISessionMap;
import com.zimax.cap.party.IUserObject;
import com.zimax.cap.party.impl.DefaultPartyUserInitService;
import com.zimax.cap.party.impl.UserObject;
import com.zimax.components.coframe.framework.IFunctionService;
import com.zimax.components.coframe.tools.IConstants;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 参与者用户初始化服务
 *
 * @author SSW
 * @date 2022-12-02
 */
public class CoframePartyUserInitService extends DefaultPartyUserInitService {

    /**
     * 初始化用户对象
     *
     * @param userId   用户编号
     * @return 用户对象
     */
    public IUserObject initUserObject(String userId) {
        UserObject userObject = null;
        ISessionMap sessionMap = DataContextManager.current().getSessionCtx();
        if (sessionMap != null) {
            userObject = (UserObject) sessionMap.getUserObject();
        }
        if (userObject == null) {
            IMUODataContext muo = DataContextManager.current().getMUODataContext();
            if (muo != null) {
                userObject = (UserObject) muo.getUserObject();
            }
        }
        if (userObject == null) {
            userObject = new UserObject();
        }

        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        InitUserObjectService bean = context.getBean(InitUserObjectService.SPRING_BEAN_NAME, InitUserObjectService.class);

        // 取用户基本信息，考虑到用户属于多机构的情况，可能会返回多条记录
        Map[] datas = bean.getUserBaseInfo(userId);

//        String empId = null;
//        Set<String> parentOrgIds = new HashSet<String>();
//        Set<String> orgList = new HashSet<String>();
//        Set<String> positionList = new HashSet<String>();
        for (int i = 0; i < datas.length; i++) {
            Map data = datas[i];
            if (i == 0) {
                userObject.put("EXTEND_USER_ID", userId);
                userObject.setUserName((String) data.get("USER_NAME"));
                userObject.setUserMail((String) data.get("EMAIL"));

//                empId = data.getString("empId");
//                if (empId != null) {
//                    userObject.setUserId(empId);
//                    userObject.setUserRealName(data.getString("empName"));
//                    userObject.setUserMail(data.getString("pEmail"));
//                    userObject.put("mobileno", data.getString("mobileno"));
//                    userObject.put("qq", data.getString("qq"));
//                    userObject.setUserOrgId(data.getString("orgId"));
//                    userObject.setUserOrgName(data.getString("orgName"));
//
//                    userObject.put(IConstants.MENU_TYPE,
//                            data.getString("menuType"));
//
//                    userObject.put("positionId", data.getString("positionId"));
//                }
            }
//            if (empId != null) {
//                // 遍历机构的orgSeqs，将机构的所有父机构数据遍历出来
//                String orgSeq = data.getString("orgSeq");
//                if (orgSeq != null) {
//                    String[] orgIdArr = StringUtils.split(orgSeq, ".");
//                    for (String orgIdStr : orgIdArr) {
//                        if (StringUtils.isNotEmpty(orgIdStr)
//                                && !StringUtils.equals(orgIdStr,
//                                data.getString("organizationId"))) {
//                            parentOrgIds.add(orgIdStr);
//                        }
//                    }
//                }
//
//                orgList.add(data.getString("organizationId"));
//
//                positionList.add(data.getString("positionId"));
//            }
        }
//
        // 如果只有用户没有员工，则把该处设置为userId
//        if (empId == null) {
            userObject.setUserId(userId);
//        }
        // 所有父机构的ID（包含多机构的情况），使用，号分隔
//        userObject.put(IConstants.PARENT_ORG_IDS,
//                StringUtils.join(parentOrgIds.iterator(), ','));
//
//        // 将当前用户的所有机构，放在扩展属性中
//        userObject.put(IConstants.ORG_LIST,
//                StringUtils.join(orgList.iterator(), ','));
//
//        // 将当前用户的所有岗位，放在扩展属性中
//        userObject.put("positionList",
//                StringUtils.join(positionList.iterator(), ','));
//
//        userObject.put(ISystemConstants.TENENT, tenantId);
//
        // 取用户权限
        Map[] roles = bean.getUserPartyAuth(userId);

        Set<String> roleSet = new HashSet<String>();
        for (Map role : roles) {
            roleSet.add((String) role.get("ROLE_ID"));
        }
        String roleList = String.join(com.zimax.cap.auth.IConstants.SPLIET, roleSet);
        userObject.put(IConstants.ROLE_LIST, roleList);

        return userObject;
    }

}
