package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.CourseHomework;

/**
 * 【请填写功能名称】Mapper接口
 * 
 * @author ruoyi
 * @date 2024-10-27
 */
public interface CourseHomeworkMapper 
{
    /**
     * 查询【请填写功能名称】
     * 
     * @param homeworkId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public CourseHomework selectCourseHomeworkByHomeworkId(Long homeworkId);

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param courseHomework 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<CourseHomework> selectCourseHomeworkList(CourseHomework courseHomework);

    /**
     * 新增【请填写功能名称】
     * 
     * @param courseHomework 【请填写功能名称】
     * @return 结果
     */
    public int insertCourseHomework(CourseHomework courseHomework);

    /**
     * 修改【请填写功能名称】
     * 
     * @param courseHomework 【请填写功能名称】
     * @return 结果
     */
    public int updateCourseHomework(CourseHomework courseHomework);

    /**
     * 删除【请填写功能名称】
     * 
     * @param homeworkId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteCourseHomeworkByHomeworkId(Long homeworkId);

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param homeworkIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCourseHomeworkByHomeworkIds(Long[] homeworkIds);
}