package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.CourseVideosMapper;
import com.ruoyi.system.domain.CourseVideos;
import com.ruoyi.system.service.ICourseVideosService;

/**
 * 课程视频Service业务层处理
 * 
 * @author ruoyi
 * @date 2024-11-24
 */
@Service
public class CourseVideosServiceImpl implements ICourseVideosService 
{
    @Autowired
    private CourseVideosMapper courseVideosMapper;

    /**
     * 查询课程视频
     * 
     * @param id 课程视频主键
     * @return 课程视频
     */
    @Override
    public CourseVideos selectCourseVideosById(Long id)
    {
        return courseVideosMapper.selectCourseVideosById(id);
    }

    /**
     * 查询课程视频列表
     * 
     * @param courseVideos 课程视频
     * @return 课程视频
     */
    @Override
    public List<CourseVideos> selectCourseVideosList(CourseVideos courseVideos)
    {
        return courseVideosMapper.selectCourseVideosList(courseVideos);
    }

    /**
     * 新增课程视频
     * 
     * @param courseVideos 课程视频
     * @return 结果
     */
    @Override
    public int insertCourseVideos(CourseVideos courseVideos)
    {
        return courseVideosMapper.insertCourseVideos(courseVideos);
    }

    /**
     * 修改课程视频
     * 
     * @param courseVideos 课程视频
     * @return 结果
     */
    @Override
    public int updateCourseVideos(CourseVideos courseVideos)
    {
        return courseVideosMapper.updateCourseVideos(courseVideos);
    }

    /**
     * 批量删除课程视频
     * 
     * @param ids 需要删除的课程视频主键
     * @return 结果
     */
    @Override
    public int deleteCourseVideosByIds(Long[] ids)
    {
        return courseVideosMapper.deleteCourseVideosByIds(ids);
    }

    /**
     * 删除课程视频信息
     * 
     * @param id 课程视频主键
     * @return 结果
     */
    @Override
    public int deleteCourseVideosById(Long id)
    {
        return courseVideosMapper.deleteCourseVideosById(id);
    }
}
