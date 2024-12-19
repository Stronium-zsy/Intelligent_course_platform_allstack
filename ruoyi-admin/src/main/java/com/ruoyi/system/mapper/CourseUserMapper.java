package com.ruoyi.system.mapper;

import java.util.List;
import java.util.Map;

import com.ruoyi.system.domain.CourseUser;
import org.apache.ibatis.annotations.Param;

/**
 * 【请填写功能名称】Mapper接口
 * 
 * @author ruoyi
 * @date 2024-11-11
 */
public interface CourseUserMapper 
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
    public int insertCourseUser(@Param("courseUserList") List<CourseUser> courseUserList);

    /**
     * 修改【请填写功能名称】
     * 
     * @param courseUser 【请填写功能名称】
     * @return 结果
     */
    public int updateCourseUser(CourseUser courseUser);

    /**
     * 删除【请填写功能名称】
     * 
     * @param courseId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteCourseUserByCourseId(Long courseId);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param courseUser 需要删除的课程Id
     * @return 结果
     */
    public int deleteCourseUserByCourseIds(CourseUser courseUser);
}
