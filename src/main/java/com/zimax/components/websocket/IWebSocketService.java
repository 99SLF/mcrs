package com.zimax.components.websocket;

/**
 * @author 李伟杰
 * @date 2023/2/16 14:44
 */

import java.util.Map;

/**
 * WebSocket服务
 *
 * @author SSW
 *
 */
public interface IWebSocketService {

    /**
     * 调用服务
     */
    @SuppressWarnings("rawtypes")
    public Object invok(Map params);

}