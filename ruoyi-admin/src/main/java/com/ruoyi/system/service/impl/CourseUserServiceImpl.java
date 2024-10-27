package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.CourseUserMapper;
import com.ruoyi.system.domain.CourseUser;
import com.ruoyi.system.service.ICourseUserService;

/**
 * 【请填写功能名称】Service业务层处理
 * 
 * @author ruoyi
 * @date 2024-10-27
 */
@Service
public class CourseUserServiceImpl implements ICourseUserService 
{
    @Autowired
    private CourseUserMapper courseUserMapper;

    /**
     * 查询【请填写功能名称】
     * 
     * @param courseId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public List<CourseUser> selectCourseUserByCourseId(Long courseId)
    {
        return courseUserMapper.selectCourseUserByCourseId(courseId);
    }


    /**
     * 查询【请填写功能名称】
     *
     * @param courseId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public List<CourseUser> selectCourseUserByUserId(Long courseId)
    {
        return courseUserMapper.selectCourseUserByUserId(courseId);
    }

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param courseUser 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<CourseUser> selectCourseUserList(CourseUser courseUser)
    {
        return courseUserMapper.selectCourseUserList(courseUser);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param courseUser 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertCourseUser(CourseUser courseUser)
    {
        return courseUserMapper.insertCourseUser(courseUser);
    }

    /**
     * 修改【请填写功能名称】
     * 
     * @param courseUser 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateCourseUser(CourseUser courseUser)
    {
        return courseUserMapper.updateCourseUser(courseUser);
    }

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param courseIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteCourseUserByCourseIds(Long[] courseIds)
    {
        return courseUserMapper.deleteCourseUserByCourseIds(courseIds);
    }

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param courseId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteCourseUserByCourseId(Long courseId)
    {
        return courseUserMapper.deleteCourseUserByCourseId(courseId);
    }
}
