package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 课程视频对象 course_videos
 * 
 * @author ruoyi
 * @date 2024-11-24
 */
public class CourseVideos extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Long courseId;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String videoPath;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String courseName;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String teacherName;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Date classTime;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setCourseId(Long courseId) 
    {
        this.courseId = courseId;
    }

    public Long getCourseId() 
    {
        return courseId;
    }
    public void setVideoPath(String videoPath) 
    {
        this.videoPath = videoPath;
    }

    public String getVideoPath() 
    {
        return videoPath;
    }
    public void setCourseName(String courseName) 
    {
        this.courseName = courseName;
    }

    public String getCourseName() 
    {
        return courseName;
    }
    public void setTeacherName(String teacherName) 
    {
        this.teacherName = teacherName;
    }

    public String getTeacherName() 
    {
        return teacherName;
    }
    public void setClassTime(Date classTime) 
    {
        this.classTime = classTime;
    }

    public Date getClassTime() 
    {
        return classTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("courseId", getCourseId())
            .append("videoPath", getVideoPath())
            .append("courseName", getCourseName())
            .append("teacherName", getTeacherName())
            .append("classTime", getClassTime())
            .toString();
    }
}
