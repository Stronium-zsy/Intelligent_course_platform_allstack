package com.ruoyi.system.util;

import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.framework.web.server.WebSocketServer;
import com.ruoyi.system.domain.CourseUser;
import com.ruoyi.system.service.ICourseUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class CourseDiscussionUtil extends RedisCache implements MessageListener {

    @Autowired
    private RedisMessageListenerContainer redisMessageListenerContainer;

    @Autowired
    private ICourseUserService courseUserService;

    // 存储频道到用户列表的映射
    private ConcurrentHashMap<Long, List<Long>> channelUserMap = new ConcurrentHashMap<>();

    // 存储用户到频道列表的映射
    private ConcurrentHashMap<Long, List<Long>> userChannelMap = new ConcurrentHashMap<>();


    @Bean
    public RedisMessageListenerContainer redisMessageListenerContainer(RedisConnectionFactory connectionFactory) {
        RedisMessageListenerContainer container = new RedisMessageListenerContainer();
        container.setConnectionFactory(connectionFactory);
        return container;
    }

    @PostConstruct
    public void initializeSubscriptions() {
        // 从数据库读取所有订阅关系
        List<CourseUser> subscriptions = courseUserService.selectCourseUserList(null);

        // 遍历订阅关系并填充映射
        for (CourseUser subscription : subscriptions) {
            Long userId = subscription.getUserId();
            Long channelName = subscription.getCourseId();

            // 更新用户到频道映射
            userChannelMap.computeIfAbsent(userId, k -> new ArrayList<>()).add(channelName);

            // 更新频道到用户映射
            channelUserMap.computeIfAbsent(channelName, k -> new ArrayList<>()).add(userId);

            // 订阅频道
            subscribeChannel(channelName);
        }
    }
    /**
     * 订阅指定的频道
     *
     * @param topic 频道名称
     */
    public void subscribeChannel(Long topic)
    {
        ChannelTopic channelTopic = new ChannelTopic(topic.toString());
        redisMessageListenerContainer.addMessageListener(this, channelTopic);

    }


    /**
     * 发布消息到指定频道，通知订阅的用户
     *
     * @param channelId 频道ID
     * @param message 消息内容
     */
    public void publishChannelMessage(Long channelId, String message) {
        // 发布消息到 Redis 频道
        redisTemplate.convertAndSend(channelId.toString(), message);
    }




    @Override
    public void onMessage(Message message, byte[] pattern) {
        String channel = new String(message.getChannel());
        String body = new String(message.getBody());

        System.out.println("Received message from channel " + channel + ": " + body);

        // 找到订阅此频道的用户
        Long channelId = Long.valueOf(channel);
        List<Long> subscribedUsers = channelUserMap.get(channelId);

        if (subscribedUsers != null) {
            for (Long userId : subscribedUsers) {
                // 处理逻辑：可以推送消息到用户或进行业务操作
                System.out.println("Notifying user " + userId + " about message: " + body);
                try {
                    WebSocketServer.sendInfo(body,userId.toString());
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }

}
