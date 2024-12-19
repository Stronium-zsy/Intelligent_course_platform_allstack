package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.CourseUser;

/**
 * 【请填写功能名称】Service接口
 * 
 * @author ruoyi
 * @date 2024-11-11
 */
public interface ICourseUserService 
{
    /**
     * 查询【请填写功能名称】
     * 
     * @param courseId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public CourseUser selectCourseUserByCourseId(Long courseId);

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param courseUser 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<CourseUser> selectCourseUserList(CourseUser courseUser);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param courseUser 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<CourseUser> selectUserNameList(CourseUser courseUser);

    public List<CourseUser> selectOtherStuList(CourseUser courseUser);

    /**
     * 新增【请填写功能名称】
     * 
     * @param courseUserList 【请填写功能名称】
     * @return 结果
     */
    public int insertCourseUser(List<CourseUser> courseUserList);

    /**
     * 修改【请填写功能名称】
     * 
     * @param courseUser 【请填写功能名称】
     * @return 结果
     */
    public int updateCourseUser(CourseUser courseUser);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param courseUser 需要删除的课程Id
     * @return 结果
     */
    public int deleteCourseUserByUserIds(CourseUser courseUser);

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param courseId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteCourseUserByCourseId(Long courseId);
}
