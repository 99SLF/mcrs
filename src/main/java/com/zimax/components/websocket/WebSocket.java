package com.zimax.components.websocket;



import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/2/16 11:29
 */
@ServerEndpoint("/websocket/{serviceIId}")
public class WebSocket {
    //与某个客户端的连接会话，需要通过它来给客户端发送数据;

    private static Map<String, List<Session>> sessionMap = new HashMap<String, List<Session>>();

    @SuppressWarnings("rawtypes")
    public static void push(String json) {
        try {
            if (session != null && session.isOpen()) {
                session.getBasicRemote().sendText(json);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String serviceIId;

    public static Session session;
    /**
     * 连接建立成功调用的方法
     * @param session  可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
     * @throws Exception
     */
    @OnOpen
    public void open(@PathParam("serviceIId") String serviceIId, Session session) {
        this.serviceIId = serviceIId;
        WebSocket.session = session;
        System.out
                .println("*** WebSocketService is Connected ***,serviceIId is "
                        + serviceIId);
    }


    /**
     * 连接关闭调用的方法
     * @throws Exception
     */
    @OnClose
    public void close() {
        System.out.println("*** WebSocketService is Closed ***,serviceIId is "
                + serviceIId);
        this.serviceIId = null;
        WebSocket.session = null;
    }

    /**
     * 收到客户端消息后调用的方法
     * @param message 客户端发送过来的消息
     * @param session 可选的参数
     * @throws IOException
     */
    @OnMessage
    public void onMessage(String message, Session session) throws IOException,
            InterruptedException {
        System.out.println(message);
    }
    /**
     * 发生错误时调用
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        System.out.println("发生错误");
        close();
    }
}

