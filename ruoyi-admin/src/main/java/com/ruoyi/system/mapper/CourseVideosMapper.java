package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.CourseVideos;

/**
 * 课程视频Mapper接口
 * 
 * @author ruoyi
 * @date 2024-11-24
 */
public interface CourseVideosMapper 
{
    /**
     * 查询课程视频
     * 
     * @param id 课程视频主键
     * @return 课程视频
     */
    public CourseVideos selectCourseVideosById(Long id);

    /**
     * 查询课程视频列表
     * 
     * @param courseVideos 课程视频
     * @return 课程视频集合
     */
    public List<CourseVideos> selectCourseVideosList(CourseVideos courseVideos);

    /**
     * 新增课程视频
     * 
     * @param courseVideos 课程视频
     * @return 结果
     */
    public int insertCourseVideos(CourseVideos courseVideos);

    /**
     * 修改课程视频
     * 
     * @param courseVideos 课程视频
     * @return 结果
     */
    public int updateCourseVideos(CourseVideos courseVideos);

    /**
     * 删除课程视频
     * 
     * @param id 课程视频主键
     * @return 结果
     */
    public int deleteCourseVideosById(Long id);

    /**
     * 批量删除课程视频
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCourseVideosByIds(Long[] ids);
}
