package com.zimax.components.coframe.framework.auth;

import com.zimax.cap.auth.manager.AuthRuntimeManager;
import com.zimax.cap.party.Party;
import com.zimax.components.coframe.framework.constants.IAppConstants;
import com.zimax.components.coframe.tools.IConstants;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 功能授权服务
 *
 * @author 苏尚文
 * @date 2022/12/9 18:01
 */
public class FunctionAuthService {

    private Logger log = Logger.getLogger(FunctionAuthService.class);

    private Party getParty(String roleId){
        return new Party(IConstants.ROLE_PARTY_TYPE_ID, roleId, null, null);
    }

    /**
     * 获取功能选中树
     *
     * @param applicationTree 应用功能树
     * @param roleId 角色编号
     * @return 功能选中树
     */
    public List<Map<String, Object>> getFunctionCheckedTree(List<Map<String, Object>> applicationTree, String roleId) {
        Party party = getParty(roleId);
        List<Map<String, Object>> ret = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : applicationTree) {
            if ("0".equals(map.get(IAppConstants.FUNCTION_IS_CHECK)) || "false".equals(map.get(IAppConstants.FUNCTION_IS_CHECK))) {
                /*  不需要权限校验的功能就不需要展示在树上 */
                continue;
            }
            String funccode = map.get("realId").toString();
            String funcType = map.get("type").toString();
            String resState = AuthRuntimeManager.getInstance().getAuthResourceState(party, funccode, funcType);
            if("1".equals(resState)){
                map.put("checked", true);
            }
            ret.add(map);
        }
        return ret;
    }

//    public boolean saveAuthFunctionsBatch(DataObject[] dataObjects, String roleId){
//        Party party = getParty(roleId);
//        AuthRuntimeManager manager = AuthRuntimeManager.getInstance();
//        List<AuthResource> authList = new ArrayList<AuthResource>();
//        for(int i = 0; i < dataObjects.length; i++){
//            String resId = dataObjects[i].get("realId").toString();
//            String resType = dataObjects[i].get("type").toString();
//            AuthResource resource = new AuthResource();
//            resource.setResourceID(resId);
//            resource.setResourceType(resType);
//            resource.setState("1");
//            authList.add(resource);
//        }
//        boolean result = true;
//        try{
//            result = manager.delAuthResBatch(party, manager.getAuthResListByRole(party, "function"), 0);
//            if (result) {
//                result = manager.delAuthResBatch(party, manager.getAuthResListByRole(party, "functiongroup"), 0);
//            }
//            if (result) {
//                result = manager.delAuthResBatch(party, manager.getAuthResListByRole(party, "application"), 0);
//            }
//            if (result) {
//                result = manager.addOrUpdateAuthResBatch(party, authList);
//            }
//        }catch (Throwable t) {
//            log.error("Save AuthFunctions failure, please do the operation again or contact the sysadmin.", t);
//            result = false;
//        }
//        return result;
//    }
}
