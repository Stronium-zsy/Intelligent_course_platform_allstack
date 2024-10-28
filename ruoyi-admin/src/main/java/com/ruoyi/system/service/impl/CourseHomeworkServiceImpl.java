package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.CourseHomeworkMapper;
import com.ruoyi.system.domain.CourseHomework;
import com.ruoyi.system.service.ICourseHomeworkService;

/**
 * 【请填写功能名称】Service业务层处理
 * 
 * @author ruoyi
 * @date 2024-10-27
 */
@Service
public class CourseHomeworkServiceImpl implements ICourseHomeworkService 
{
    @Autowired
    private CourseHomeworkMapper courseHomeworkMapper;

    /**
     * 查询【请填写功能名称】
     * 
     * @param homeworkId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public CourseHomework selectCourseHomeworkByHomeworkId(Long homeworkId)
    {
        return courseHomeworkMapper.selectCourseHomeworkByHomeworkId(homeworkId);
    }

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param courseHomework 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<CourseHomework> selectCourseHomeworkList(CourseHomework courseHomework)
    {
        return courseHomeworkMapper.selectCourseHomeworkList(courseHomework);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param courseHomework 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertCourseHomework(CourseHomework courseHomework)
    {
        return courseHomeworkMapper.insertCourseHomework(courseHomework);
    }

    /**
     * 修改【请填写功能名称】
     * 
     * @param courseHomework 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateCourseHomework(CourseHomework courseHomework)
    {
        return courseHomeworkMapper.updateCourseHomework(courseHomework);
    }

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param homeworkIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteCourseHomeworkByHomeworkIds(Long[] homeworkIds)
    {
        return courseHomeworkMapper.deleteCourseHomeworkByHomeworkIds(homeworkIds);
    }

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param homeworkId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteCourseHomeworkByHomeworkId(Long homeworkId)
    {
        return courseHomeworkMapper.deleteCourseHomeworkByHomeworkId(homeworkId);
    }
}
