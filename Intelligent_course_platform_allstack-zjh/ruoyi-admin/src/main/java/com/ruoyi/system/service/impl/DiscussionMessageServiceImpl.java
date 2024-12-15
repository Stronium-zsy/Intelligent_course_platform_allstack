package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.DiscussionMessageMapper;
import com.ruoyi.system.domain.DiscussionMessage;
import com.ruoyi.system.service.IDiscussionMessageService;

/**
 * 【请填写功能名称】Service业务层处理
 * 
 * @author ruoyi
 * @date 2024-11-20
 */
@Service
public class DiscussionMessageServiceImpl implements IDiscussionMessageService 
{
    @Autowired
    private DiscussionMessageMapper discussionMessageMapper;

    /**
     * 查询【请填写功能名称】
     * 
     * @param messageId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public DiscussionMessage selectDiscussionMessageByMessageId(Long messageId)
    {
        return discussionMessageMapper.selectDiscussionMessageByMessageId(messageId);
    }

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param discussionMessage 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<DiscussionMessage> selectDiscussionMessageList(DiscussionMessage discussionMessage)
    {
        return discussionMessageMapper.selectDiscussionMessageList(discussionMessage);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param discussionMessage 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertDiscussionMessage(DiscussionMessage discussionMessage)
    {
        return discussionMessageMapper.insertDiscussionMessage(discussionMessage);
    }

    /**
     * 修改【请填写功能名称】
     * 
     * @param discussionMessage 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateDiscussionMessage(DiscussionMessage discussionMessage)
    {
        return discussionMessageMapper.updateDiscussionMessage(discussionMessage);
    }

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param messageIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteDiscussionMessageByMessageIds(Long[] messageIds)
    {
        return discussionMessageMapper.deleteDiscussionMessageByMessageIds(messageIds);
    }

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param messageId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteDiscussionMessageByMessageId(Long messageId)
    {
        return discussionMessageMapper.deleteDiscussionMessageByMessageId(messageId);
    }
}
