package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 【请填写功能名称】对象 scores
 * 
 * @author ruoyi
 * @date 2024-12-20
 */
public class Scores extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private String scorer;

    /** $column.columnComment */
    private String bescorer;

    /** $column.columnComment */
    private String homeworkId;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Long score;

    public void setScorer(String scorer) 
    {
        this.scorer = scorer;
    }

    public String getScorer() 
    {
        return scorer;
    }
    public void setBescorer(String bescorer) 
    {
        this.bescorer = bescorer;
    }

    public String getBescorer() 
    {
        return bescorer;
    }
    public void setHomeworkId(String homeworkId) 
    {
        this.homeworkId = homeworkId;
    }

    public String getHomeworkId() 
    {
        return homeworkId;
    }
    public void setScore(Long score) 
    {
        this.score = score;
    }

    public Long getScore() 
    {
        return score;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("scorer", getScorer())
            .append("bescorer", getBescorer())
            .append("homeworkId", getHomeworkId())
            .append("score", getScore())
            .toString();
    }
}
