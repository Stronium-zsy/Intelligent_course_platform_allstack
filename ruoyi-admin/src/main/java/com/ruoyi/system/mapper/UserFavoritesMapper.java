package com.ruoyi.system.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.ruoyi.system.domain.UserFavorites;
import io.lettuce.core.dynamic.annotation.Param;
import org.apache.ibatis.annotations.Delete;

public interface UserFavoritesMapper {

    // 根据主键查询收藏
    UserFavorites selectUserFavoritesByFavoriteId(Long favoriteId);

    // 查询用户收藏列表
    List<UserFavorites> selectUserFavoritesList(UserFavorites userFavorites);

    // 新增收藏
    int insertUserFavorites(UserFavorites userFavorites);

    // 修改收藏
    int updateUserFavorites(UserFavorites userFavorites);

    // 根据主键删除收藏
    int deleteUserFavoritesByFavoriteId(Long favoriteId);

    // 批量删除收藏
    int deleteUserFavoritesByFavoriteIds(Long[] favoriteIds);

    // 根据用户ID和帖子ID查询收藏
    UserFavorites selectUserFavoritesByUserIdAndPostId(Map<String, Object> params);



    int deleteUserFavorites(Map<String, Object> params);


    boolean existsByUserIdAndPostId(@Param("userId") Long userId, @Param("postId") Long postId);

    // 增加帖子收藏数
    int incrementPostFavoritesCount(@Param("postId") Long postId);

    // 减少帖子收藏数
    int decrementPostFavoritesCount(@Param("postId") Long postId);

    /**
     * 获取帖子收藏数
     *
     * @param postId 帖子ID
     * @return 收藏数
     */
    int getFavoritesCountByPostId(@Param("postId") Long postId);


    public List<UserFavorites> selectUserFavoritesByCriteria(UserFavorites userFavorites);


}
