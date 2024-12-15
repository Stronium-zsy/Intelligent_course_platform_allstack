package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 用户收藏对象 user_favorites
 * 
 * @author ruoyi
 * @date 2024-12-15
 */
public class UserFavorites extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 收藏记录ID */
    private Long favoriteId;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 帖子ID */
    @Excel(name = "帖子ID")
    private Long postId;

    private String postTitle; // 新增字段：帖子标题
    /** 收藏时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "收藏时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date favoriteTime;

    public void setFavoriteId(Long favoriteId) 
    {
        this.favoriteId = favoriteId;
    }

    public Long getFavoriteId() 
    {
        return favoriteId;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setPostId(Long postId) 
    {
        this.postId = postId;
    }

    public Long getPostId() 
    {
        return postId;
    }
    public void setFavoriteTime(Date favoriteTime) 
    {
        this.favoriteTime = favoriteTime;
    }

    public Date getFavoriteTime() 
    {
        return favoriteTime;
    }

    // Getter 和 Setter 方法
    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("favoriteId", getFavoriteId())
            .append("userId", getUserId())
            .append("postId", getPostId())
            .append("favoriteTime", getFavoriteTime())
            .toString();
    }
}
