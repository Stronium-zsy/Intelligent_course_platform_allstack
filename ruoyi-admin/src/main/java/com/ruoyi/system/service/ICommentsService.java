package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.Comments;

/**
 * 【请填写功能名称】Service接口
 * 
 * @author ruoyi
 * @date 2024-12-03
 */
public interface ICommentsService 
{
    /**
     * 查询【请填写功能名称】
     * 
     * @param commentId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public Comments selectCommentsByCommentId(Long commentId);

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param comments 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<Comments> selectCommentsList(Comments comments);

    /**
     * 新增【请填写功能名称】
     * 
     * @param comments 【请填写功能名称】
     * @return 结果
     */
    public int insertComments(Comments comments);

    /**
     * 修改【请填写功能名称】
     * 
     * @param comments 【请填写功能名称】
     * @return 结果
     */
    public int updateComments(Comments comments);

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param commentIds 需要删除的【请填写功能名称】主键集合
     * @return 结果
     */
    public int deleteCommentsByCommentIds(Long[] commentIds);

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param commentId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteCommentsByCommentId(Long commentId);
}
