package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.CommentsMapper;
import com.ruoyi.system.domain.Comments;
import com.ruoyi.system.service.ICommentsService;

/**
 * 【请填写功能名称】Service业务层处理
 * 
 * @author ruoyi
 * @date 2024-12-03
 */
@Service
public class CommentsServiceImpl implements ICommentsService 
{
    @Autowired
    private CommentsMapper commentsMapper;

    /**
     * 查询【请填写功能名称】
     * 
     * @param commentId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public Comments selectCommentsByCommentId(Long commentId)
    {
        return commentsMapper.selectCommentsByCommentId(commentId);
    }

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param comments 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<Comments> selectCommentsList(Comments comments)
    {
        return commentsMapper.selectCommentsList(comments);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param comments 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertComments(Comments comments)
    {
        return commentsMapper.insertComments(comments);
    }

    /**
     * 修改【请填写功能名称】
     * 
     * @param comments 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateComments(Comments comments)
    {
        return commentsMapper.updateComments(comments);
    }

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param commentIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteCommentsByCommentIds(Long[] commentIds)
    {
        return commentsMapper.deleteCommentsByCommentIds(commentIds);
    }

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param commentId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteCommentsByCommentId(Long commentId)
    {
        return commentsMapper.deleteCommentsByCommentId(commentId);
    }
}
