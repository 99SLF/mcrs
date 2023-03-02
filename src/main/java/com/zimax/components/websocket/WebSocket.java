package com.zimax.components.websocket;
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
//主要是将目前的类定义成一个websocket服务器端, 注解的值将被用于监听用户连接的终端访问URL地址,客户端可以通过这个URL来连接到WebSocket服务器端
@ServerEndpoint("/websocket/{serviceId}")
public class WebSocket {


    private static Map<String, List<Session>> sessionMap = new HashMap<String, List<Session>>();
    private String serviceId;
    public static Session session;


    //订阅,与某个客户端的连接会话，需要通过它来给客户端发送数据;
    //@SuppressWarnings，表示警告抑制，告诉编译器不用提示相关的警告信息。
    @SuppressWarnings("rawtypes") //"rawtypes"，这个参数是告诉编译器不用提示使用基本类型参数时相关的警告信息。一般是在通过传参调用某个方法的时候进行标识。
    public static void push(String serviceId,String json) {
        try {
            List<Session> sessions = sessionMap.get(serviceId);
            if (sessions != null && !sessions.isEmpty()) {
                for (Session session : sessions) {
                    if (session.isOpen()) {
                        session.getBasicRemote().sendText(json);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Open(@onOpen)：服务器响应websocket的请求会触发
     * 连接建立成功调用的方法
     * @param session  可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
     * @throws Exception
     *
     */
    @OnOpen
    public void open(@PathParam("serviceId") String serviceId, Session session) {
        this.serviceId = serviceId;
        WebSocket.session = session;
        List<Session> sessions = sessionMap.get(serviceId);
        if (sessions == null) {
            sessions = new ArrayList<Session>();
            sessionMap.put(serviceId, sessions);
        }
        sessions.add(session);
        System.out.println("*** WebSocketService is Connected ***,serviceIId is " + serviceId);
    }


    /**
     * Message(@onMessage)：当消息被接收时会触发
     * 收到客户端消息后调用的方法
     * @param message 客户端发送过来的消息
     * @param session 可选的参数
     * @throws IOException
     */
    @OnMessage
    public void onMessage(String message, Session session) throws IOException, InterruptedException {
        System.out.println(message);
    }

    /**
     * Close(@onClose)：当连接关闭时会触发，关闭之后，服务端和客户端就不能发消息了
     * 连接关闭调用的方法
     * @throws Exception
     */
    @OnClose
    public void close() {
        System.out.println("*** WebSocketService is Closed ***,serviceIId is " + serviceId);
        this.serviceId = null;
        WebSocket.session = null;
    }

    /**
     *  Error(@onError)：发生错误会触发，并会告诉你错误的原因
     * 连接发生错误时调用
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        System.out.println("发生错误");
        close();
    }
}
//    //群发
//    @SuppressWarnings("rawtypes")
//    public static void push(String json) {
//        try {
//            if (session != null && session.isOpen()) {
//                session.getBasicRemote().sendText(json);
//            }
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }
