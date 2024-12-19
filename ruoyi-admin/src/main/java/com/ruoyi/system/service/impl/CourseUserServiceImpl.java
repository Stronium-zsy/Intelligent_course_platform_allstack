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
 * @date 2024-11-11
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
    public CourseUser selectCourseUserByCourseId(Long courseId)
    {
        return courseUserMapper.selectCourseUserByCourseId(courseId);
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
     * 查询【请填写功能名称】列表
     *
     * @param courseUser 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<CourseUser> selectUserNameList(CourseUser courseUser)
    {
        return courseUserMapper.selectUserNameList(courseUser);
    }

    @Override
    public List<CourseUser> selectOtherStuList(CourseUser courseUser)
    {
        return courseUserMapper.selectOtherStuList(courseUser);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param courseUserList 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertCourseUser(List<CourseUser> courseUserList)
    {
        return courseUserMapper.insertCourseUser(courseUserList);
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
     * @param courseUser 需要删除的课程Id
     * @return 结果
     */
    @Override
    public int deleteCourseUserByUserIds(CourseUser courseUser)
    {
        return courseUserMapper.deleteCourseUserByCourseIds(courseUser);
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
