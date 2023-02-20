package com.zimax.components.websocket;
import org.codehaus.jettison.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.Session;
/**
 * @author 李伟杰
 * @date 2023/2/17 14:41
 */
public class RefreshThread extends Thread {

    private List<Session> sessions = new ArrayList<Session>();

    private IWebSocketService service;

    private int interval;

    private volatile boolean stop = false;

    private String lastText = "";

    private Map<Session, String> lastTexts = new HashMap<Session, String>();

    public RefreshThread(Session session, IWebSocketService service,
                         int interval) {
        sessions.add(session);
        this.service = service;
        this.interval = interval;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void run() {
        if (interval > 0) {
            stop = false;
            while (!stop) {
                try {
                    if (!stop && !sessions.isEmpty()) {
                        List<Session> notParamSessions = getNotParamSessions();
                        if (!notParamSessions.isEmpty()) {
                            Object result = service.invok(new HashMap());
                            String text = Util.transform(result).toString();
                            if (!lastText.equals(text)) {
                                for (Session session : notParamSessions) {
                                    if (session.isOpen()) {
                                        session.getBasicRemote().sendText(text);
                                    }
                                }
                                lastText = text;
                            }
                        }
                        List<Session> paramSessions = getParamSessions();
                        if (!paramSessions.isEmpty()) {
                            for (Session session : paramSessions) {
                                Map<String, List<String>> requestParameterMap = session
                                        .getRequestParameterMap();
                                Object result = service.invok(Util
                                        .toMap((JSONObject) requestParameterMap));
                                String text = Util.transform(result).toString();
                                if (!text.equals(lastTexts.get(session))) {
                                    if (session.isOpen()) {
                                        session.getBasicRemote().sendText(text);
                                    }
                                    lastTexts.put(session, text);
                                }
                            }
                        }
                    }
                    Thread.sleep(interval);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private List<Session> getNotParamSessions() {
        List<Session> result = new ArrayList<Session>();
        for (Session session : this.sessions) {
            if (session.getRequestParameterMap().isEmpty()) {
                result.add(session);
            }
        }
        return result;
    }

    private List<Session> getParamSessions() {
        List<Session> result = new ArrayList<Session>();
        for (Session session : this.sessions) {
            if (!session.getRequestParameterMap().isEmpty()) {
                result.add(session);
            }
        }
        return result;
    }

    public void addSession(Session session) {
        sessions.add(session);
    }

    public boolean removeSession(Session session) {
        return sessions.remove(session);
    }

    public int getSessionSize() {
        return sessions.size();
    }

    // 关闭线程
    public void stopThread() {
        this.stop = true;
    }

}