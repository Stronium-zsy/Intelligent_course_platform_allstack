package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.Posts;

/**
 * 【请填写功能名称】Service接口
 * 
 * @author ruoyi
 * @date 2024-12-03
 */
public interface IPostsService 
{
    /**
     * 查询【请填写功能名称】
     * 
     * @param postId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public Posts selectPostsByPostId(Long postId);

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param posts 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<Posts> selectPostsList(Posts posts);

    /**
     * 新增【请填写功能名称】
     * 
     * @param posts 【请填写功能名称】
     * @return 结果
     */
    public int insertPosts(Posts posts);

    /**
     * 修改【请填写功能名称】
     * 
     * @param posts 【请填写功能名称】
     * @return 结果
     */
    public int updatePosts(Posts posts);

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param postIds 需要删除的【请填写功能名称】主键集合
     * @return 结果
     */
    public int deletePostsByPostIds(Long[] postIds);

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param postId 【请填写功能名称】主键
     * @return 结果
     */
    public int deletePostsByPostId(Long postId);
}
