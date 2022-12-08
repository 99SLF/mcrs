package com.zimax.cap.common.muo;

/**
 * @author 苏尚文
 * @date 2022/12/7 9:56
 */
public class VirtualUserObjectTypes {

    private static final String[] userTypes = {"server", "workflow", "portal"};

    public static final String SERVER_USER = userTypes[0];

    public static final String WORKFLOW_USER = userTypes[1];

    public static final String PORTAL_USER = userTypes[2];

    public static boolean isSystemUserType(String userType) {
        if (userType == null) {
            return false;
        }
        for (int i = 0; i < userTypes.length; i++) {
            if (userTypes[i].equals(userType)) {
                return true;
            }
        }
        return false;
    }
}
