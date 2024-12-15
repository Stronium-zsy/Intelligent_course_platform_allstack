package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.DiscussionMessage;

/**
 * 【请填写功能名称】Mapper接口
 * 
 * @author ruoyi
 * @date 2024-11-20
 */
public interface DiscussionMessageMapper 
{
    /**
     * 查询【请填写功能名称】
     * 
     * @param messageId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public DiscussionMessage selectDiscussionMessageByMessageId(Long messageId);

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param discussionMessage 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<DiscussionMessage> selectDiscussionMessageList(DiscussionMessage discussionMessage);

    /**
     * 新增【请填写功能名称】
     * 
     * @param discussionMessage 【请填写功能名称】
     * @return 结果
     */
    public int insertDiscussionMessage(DiscussionMessage discussionMessage);

    /**
     * 修改【请填写功能名称】
     * 
     * @param discussionMessage 【请填写功能名称】
     * @return 结果
     */
    public int updateDiscussionMessage(DiscussionMessage discussionMessage);

    /**
     * 删除【请填写功能名称】
     * 
     * @param messageId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteDiscussionMessageByMessageId(Long messageId);

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param messageIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteDiscussionMessageByMessageIds(Long[] messageIds);
}
