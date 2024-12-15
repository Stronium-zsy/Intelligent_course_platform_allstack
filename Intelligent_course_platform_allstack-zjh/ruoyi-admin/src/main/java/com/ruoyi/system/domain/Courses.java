package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 【请填写功能名称】对象 courses
 * 
 * @author ruoyi
 * @date 2024-11-11
 */
public class Courses extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long courseId;

    public String getCourseImage() {
        return courseImage;
    }

    public void setCourseImage(String courseImage) {
        this.courseImage = courseImage;
    }

    private String courseImage;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String courseSource;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String courseVideo;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String courseName;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String courseDescription;

    public void setCourseId(Long courseId) 
    {
        this.courseId = courseId;
    }

    public Long getCourseId() 
    {
        return courseId;
    }
    public void setCourseSource(String courseSource) 
    {
        this.courseSource = courseSource;
    }

    public String getCourseSource() 
    {
        return courseSource;
    }
    public void setCourseVideo(String courseVideo) 
    {
        this.courseVideo = courseVideo;
    }

    public String getCourseVideo() 
    {
        return courseVideo;
    }
    public void setCourseName(String courseName) 
    {
        this.courseName = courseName;
    }

    public String getCourseName() 
    {
        return courseName;
    }
    public void setCourseDescription(String courseDescription) 
    {
        this.courseDescription = courseDescription;
    }

    public String getCourseDescription() 
    {
        return courseDescription;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("courseId", getCourseId())
            .append("courseSource", getCourseSource())
            .append("courseVideo", getCourseVideo())
            .append("courseName", getCourseName())
            .append("courseDescription", getCourseDescription())
            .toString();
    }
}
