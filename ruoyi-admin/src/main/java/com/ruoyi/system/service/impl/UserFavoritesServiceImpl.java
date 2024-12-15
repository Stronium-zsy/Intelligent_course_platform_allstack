package com.ruoyi.system.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.UserFavoritesMapper;
import com.ruoyi.system.mapper.PostsMapper; // 假设有 PostsMapper 操作 posts 表
import com.ruoyi.system.domain.UserFavorites;
import com.ruoyi.system.service.IUserFavoritesService;
import org.springframework.transaction.annotation.Transactional;

/**
 * 用户收藏Service业务层处理
 */
@Service
public class UserFavoritesServiceImpl implements IUserFavoritesService {

    @Autowired
    private UserFavoritesMapper userFavoritesMapper;

    @Autowired
    private PostsMapper postsMapper; // 用于更新帖子收藏数

    @Override
    public List<UserFavorites> selectUserFavoritesList(UserFavorites userFavorites) {
        return userFavoritesMapper.selectUserFavoritesList(userFavorites);
    }

    @Override
    public UserFavorites selectUserFavoritesByFavoriteId(Long favoriteId) {
        return userFavoritesMapper.selectUserFavoritesByFavoriteId(favoriteId);
    }

    @Override
    public int insertUserFavorites(UserFavorites userFavorites) {
        return userFavoritesMapper.insertUserFavorites(userFavorites);
    }

    @Override
    public int updateUserFavorites(UserFavorites userFavorites) {
        return userFavoritesMapper.updateUserFavorites(userFavorites);
    }

    @Override
    public int deleteUserFavoritesByFavoriteIds(Long[] favoriteIds) {
        return userFavoritesMapper.deleteUserFavoritesByFavoriteIds(favoriteIds);
    }

    @Override
    public boolean toggleFavorite(UserFavorites userFavorites) {
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userFavorites.getUserId());
        params.put("postId", userFavorites.getPostId());

        UserFavorites existingFavorite = userFavoritesMapper.selectUserFavoritesByUserIdAndPostId(params);
        if (existingFavorite != null) {
            // 删除收藏
            userFavoritesMapper.deleteUserFavorites(params);
            userFavoritesMapper.decrementPostFavoritesCount(userFavorites.getPostId());
            return false; // 取消收藏
        } else {
            // 新增收藏
            userFavorites.setFavoriteTime(new Date());
            userFavoritesMapper.insertUserFavorites(userFavorites);
            userFavoritesMapper.incrementPostFavoritesCount(userFavorites.getPostId());
            return true; // 收藏成功
        }
    }


    @Override
    public int getFavoritesCountByPostId(Long postId) {
        return userFavoritesMapper.getFavoritesCountByPostId(postId);
    }


    @Override
    @Transactional
    public int deleteUserFavorites(Long[] favoriteIds) {
        for (Long favoriteId : favoriteIds) {
            // 查询收藏记录的详细信息
            UserFavorites favorite = userFavoritesMapper.selectUserFavoritesByFavoriteId(favoriteId);
            if (favorite != null) {
                // 删除收藏记录
                userFavoritesMapper.deleteUserFavoritesByFavoriteId(favoriteId);

                // 减少帖子收藏数
                userFavoritesMapper.decrementPostFavoritesCount(favorite.getPostId());

                // 如果评论表需要更新收藏数，也可以添加逻辑
                // userFavoritesMapper.decrementCommentFavoritesCount(favorite.getPostId());
            }
        }
        return favoriteIds.length;
    }
}
