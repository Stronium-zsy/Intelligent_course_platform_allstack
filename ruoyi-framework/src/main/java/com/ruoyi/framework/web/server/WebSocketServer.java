package com.ruoyi.framework.web.server;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.concurrent.CopyOnWriteArraySet;

@ServerEndpoint("/ws/{sid}")
@Component
public class WebSocketServer {

    // 日志对象
    private static final Logger log = LoggerFactory.getLogger(WebSocketServer.class);

    // 静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
    private static int onlineCount = 0;

    // concurrent 包的线程安全 Set，用来存放每个客户端对应的 WebSocketServer 对象。
    private static final CopyOnWriteArraySet<WebSocketServer> webSocketSet = new CopyOnWriteArraySet<>();

    // 与某个客户端的连接会话，需要通过它来给客户端发送数据
    private Session session;

    // 接收 sid
    private String sid = "";

    /**
     * 客户端创建连接时触发
     */
    @OnOpen
    public void onOpen(Session session, @PathParam("sid") String sid) {
        // 检查是否已有相同 sid 的连接
        for (WebSocketServer webSocket : webSocketSet) {
            if (webSocket.sid.equals(sid)) {
                log.info("窗口 " + sid + " 已存在连接，拒绝新的连接");
                try {
                    session.close(); // 拒绝新的连接
                } catch (IOException e) {
                    log.error("关闭重复连接时出现异常", e);
                }
                return; // 不允许重复连接，直接返回
            }
        }

        this.session = session;
        this.sid = sid;

        webSocketSet.add(this); // 加入 Set 中
        addOnlineCount(); // 在线数加1
        log.info("有新窗口开始监听: " + sid + ", 当前在线人数为 " + getOnlineCount());
        try {
            sendMessage("连接成功");
        } catch (IOException e) {
            log.error("WebSocket IO 异常", e);
        }
    }

    /**
     * 客户端连接关闭时触发
     */
    @OnClose
    public void onClose() {
        webSocketSet.remove(this); // 从 Set 中删除
        subOnlineCount(); // 在线数减1
        log.info("窗口 " + sid + " 连接关闭！当前在线人数为 " + getOnlineCount());
    }

    /**
     * 接收到客户端消息时触发
     */
    @OnMessage
    public void onMessage(String message, Session session) {
        log.info("收到来自窗口 " + sid + " 的信息: " + message);
        // 群发消息
        for (WebSocketServer item : webSocketSet) {
            try {
                item.sendMessage(message);
            } catch (IOException e) {
                log.error("消息发送失败", e);
            }
        }
    }

    /**
     * 连接发生异常时触发
     */
    @OnError
    public void onError(Session session, Throwable error) {
        log.error("发生错误，窗口 " + sid);
        error.printStackTrace();
    }

    /**
     * 实现服务器主动推送（向浏览器发消息）
     */
    public void sendMessage(String message) throws IOException {
        log.info("服务器推送消息到窗口 " + sid + ": " + message);
        this.session.getBasicRemote().sendText(message);
    }

    /**
     * 发送消息到所有客户端
     * 指定 sid 则向指定客户端发消息
     * 不指定 sid 则向所有客户端发送消息
     */
    public static void sendInfo(String message, @PathParam("sid") String sid) throws IOException {
        if (sid != null) {
            // 判断 sid 是否已连接
            WebSocketServer targetWebSocket = null;
            for (WebSocketServer item : webSocketSet) {
                if (item.sid.equals(sid)) {
                    targetWebSocket = item;
                    break;
                }
            }

            if (targetWebSocket == null) {
                log.warn("推送失败，窗口 " + sid + " 未连接");
                return; // sid 未连接，直接返回
            }

            // 推送消息到指定 sid
            try {
                log.info("推送消息到窗口 " + sid + "，推送内容: " + message);
                targetWebSocket.sendMessage(message);
            } catch (IOException e) {
                log.error("推送消息到窗口 " + sid + " 失败", e);
            }
        } else {
            // 广播消息
            log.info("推送广播消息，内容: " + message);
            for (WebSocketServer item : webSocketSet) {
                try {
                    item.sendMessage(message);
                } catch (IOException e) {
                    log.error("广播消息发送失败", e);
                }
            }
        }
    }

    public static synchronized int getOnlineCount() {
        return onlineCount;
    }

    public static synchronized void addOnlineCount() {
        WebSocketServer.onlineCount++;
    }

    public static synchronized void subOnlineCount() {
        WebSocketServer.onlineCount--;
    }
}
