package com.ruoyi.system.service;

import java.util.Date;
import java.util.List;
import com.ruoyi.system.domain.UserFavorites;

/**
 * 用户收藏Service接口
 */
public interface IUserFavoritesService {

    List<UserFavorites> selectUserFavoritesList(UserFavorites userFavorites);

    UserFavorites selectUserFavoritesByFavoriteId(Long favoriteId);

    int insertUserFavorites(UserFavorites userFavorites);

    int updateUserFavorites(UserFavorites userFavorites);

    int deleteUserFavoritesByFavoriteIds(Long[] favoriteIds);

    /**
     * 新增或取消收藏
     *
     * @param userFavorites 收藏对象
     * @return true 表示新增收藏；false 表示取消收藏
     */
    boolean toggleFavorite(UserFavorites userFavorites);

    /**
     * 根据帖子ID获取收藏数
     *
     * @param postId 帖子ID
     * @return 收藏数
     */
    int getFavoritesCountByPostId(Long postId);

    /**
     * 删除收藏记录，同时更新帖子或评论的收藏数
     *
     * @param favoriteIds 收藏记录ID数组
     * @return 删除的记录数
     */
    int deleteUserFavorites(Long[] favoriteIds);

    /**
     * 根据用户名和时间条件查询收藏记录
     * @param userFavorites 包含查询条件的对象
     * @return 用户收藏记录列表
     */
    List<UserFavorites> selectUserFavoritesByCriteria(UserFavorites userFavorites);

}
