package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.CourseUser;

/**
 * 【请填写功能名称】Mapper接口
 * 
 * @author ruoyi
 * @date 2024-10-27
 */
public interface CourseUserMapper 
{
    /**
     * 查询【请填写功能名称】
     * 
     * @param courseId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public List<CourseUser> selectCourseUserByCourseId(Long courseId);


    /**
     * 查询【请填写功能名称】
     *
     * @param userId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public List<CourseUser> selectCourseUserByUserId(Long userId);

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param courseUser 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<CourseUser> selectCourseUserList(CourseUser courseUser);



    /**
     * 新增【请填写功能名称】
     * 
     * @param courseUser 【请填写功能名称】
     * @return 结果
     */
    public int insertCourseUser(CourseUser courseUser);

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
     * @param courseIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCourseUserByCourseIds(Long[] courseIds);
}