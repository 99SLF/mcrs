package com.zimax.components.coframe.tools;

/**
 * 授权常量
 *
 * @author 苏尚文
 * @date 2022/12/6 16:14
 */
public interface IAuthConstants {

    /**
     * 将功能适配resourceType为function字符串 Comment for
     * <code>FUNCTION_TO_RESOURCE_TYPE</code>
     */
    String FUNCTION_TO_RESOURCE_TYPE = "function";

    /**
     * 0代表无权限，1代表有权限 Comment for <code>FUNCTION_TO_STATES</code>
     */
    String[] FUNCTION_TO_STATES = new String[] {
            "0", "1"
    };

    String FUNCTION_ACTION = "function_action";

    String FUNCTION_PARAN_RESOURCE_ID = "__resourceId";

    String FUNCTION_PARAM_REAOURCE_TYPE = "__resourceType";
}
