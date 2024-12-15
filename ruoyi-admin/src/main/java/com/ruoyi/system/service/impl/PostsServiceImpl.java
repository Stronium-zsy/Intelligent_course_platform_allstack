package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.PostsMapper;
import com.ruoyi.system.domain.Posts;
import com.ruoyi.system.service.IPostsService;

/**
 * 【请填写功能名称】Service业务层处理
 * 
 * @author ruoyi
 * @date 2024-12-03
 */
@Service
public class PostsServiceImpl implements IPostsService 
{
    @Autowired
    private PostsMapper postsMapper;

    /**
     * 查询【请填写功能名称】
     * 
     * @param postId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public Posts selectPostsByPostId(Long postId)
    {
        return postsMapper.selectPostsByPostId(postId);
    }

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param posts 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<Posts> selectPostsList(Posts posts)
    {
        return postsMapper.selectPostsList(posts);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param posts 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertPosts(Posts posts)
    {
        return postsMapper.insertPosts(posts);
    }

    /**
     * 修改【请填写功能名称】
     * 
     * @param posts 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updatePosts(Posts posts)
    {
        return postsMapper.updatePosts(posts);
    }

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param postIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deletePostsByPostIds(Long[] postIds)
    {
        return postsMapper.deletePostsByPostIds(postIds);
    }

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param postId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deletePostsByPostId(Long postId)
    {
        return postsMapper.deletePostsByPostId(postId);
    }
}
