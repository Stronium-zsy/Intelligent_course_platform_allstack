package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 【请填写功能名称】对象 comments
 * 
 * @author ruoyi
 * @date 2024-12-03
 */
public class Comments extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long commentId;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Long postId;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Long userId;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Long commentIndex;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String authorName;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String content;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Date commentTime;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Long likesCount;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Long favoritesCount;

    public void setCommentId(Long commentId) 
    {
        this.commentId = commentId;
    }

    public Long getCommentId() 
    {
        return commentId;
    }
    public void setPostId(Long postId) 
    {
        this.postId = postId;
    }

    public Long getPostId() 
    {
        return postId;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setCommentIndex(Long commentIndex) 
    {
        this.commentIndex = commentIndex;
    }

    public Long getCommentIndex() 
    {
        return commentIndex;
    }
    public void setAuthorName(String authorName) 
    {
        this.authorName = authorName;
    }

    public String getAuthorName() 
    {
        return authorName;
    }
    public void setContent(String content) 
    {
        this.content = content;
    }

    public String getContent() 
    {
        return content;
    }
    public void setCommentTime(Date commentTime) 
    {
        this.commentTime = commentTime;
    }

    public Date getCommentTime() 
    {
        return commentTime;
    }
    public void setLikesCount(Long likesCount) 
    {
        this.likesCount = likesCount;
    }

    public Long getLikesCount() 
    {
        return likesCount;
    }
    public void setFavoritesCount(Long favoritesCount) 
    {
        this.favoritesCount = favoritesCount;
    }

    public Long getFavoritesCount() 
    {
        return favoritesCount;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("commentId", getCommentId())
            .append("postId", getPostId())
            .append("userId", getUserId())
            .append("commentIndex", getCommentIndex())
            .append("authorName", getAuthorName())
            .append("content", getContent())
            .append("commentTime", getCommentTime())
            .append("likesCount", getLikesCount())
            .append("favoritesCount", getFavoritesCount())
            .toString();
    }
}
