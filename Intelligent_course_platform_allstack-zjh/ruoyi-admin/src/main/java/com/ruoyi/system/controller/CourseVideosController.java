package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.CourseVideos;
import com.ruoyi.system.service.ICourseVideosService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 课程视频Controller
 * 
 * @author ruoyi
 * @date 2024-11-24
 */
@RestController
@RequestMapping("/system/videos")
public class CourseVideosController extends BaseController
{
    @Autowired
    private ICourseVideosService courseVideosService;

    /**
     * 查询课程视频列表
     */
    @PreAuthorize("@ss.hasPermi('system:videos:list')")
    @GetMapping("/list")
    public TableDataInfo list(CourseVideos courseVideos)
    {
        startPage();
        List<CourseVideos> list = courseVideosService.selectCourseVideosList(courseVideos);
        return getDataTable(list);
    }

    /**
     * 导出课程视频列表
     */
    @PreAuthorize("@ss.hasPermi('system:videos:export')")
    @Log(title = "课程视频", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CourseVideos courseVideos)
    {
        List<CourseVideos> list = courseVideosService.selectCourseVideosList(courseVideos);
        ExcelUtil<CourseVideos> util = new ExcelUtil<CourseVideos>(CourseVideos.class);
        util.exportExcel(response, list, "课程视频数据");
    }

    /**
     * 获取课程视频详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:videos:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(courseVideosService.selectCourseVideosById(id));
    }

    /**
     * 新增课程视频
     */
    @PreAuthorize("@ss.hasPermi('system:videos:add')")
    @Log(title = "课程视频", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CourseVideos courseVideos)
    {
        return toAjax(courseVideosService.insertCourseVideos(courseVideos));
    }

    /**
     * 修改课程视频
     */
    @PreAuthorize("@ss.hasPermi('system:videos:edit')")
    @Log(title = "课程视频", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CourseVideos courseVideos)
    {
        return toAjax(courseVideosService.updateCourseVideos(courseVideos));
    }

    /**
     * 删除课程视频
     */
    @PreAuthorize("@ss.hasPermi('system:videos:remove')")
    @Log(title = "课程视频", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(courseVideosService.deleteCourseVideosByIds(ids));
    }
}
