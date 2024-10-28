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
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.CourseHomework;
import com.ruoyi.system.service.ICourseHomeworkService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 课程作业管理Controller
 *
 * @date 2024-10-27
 */
@Api("课程作业管理")
@RestController
@RequestMapping("/system/course_homework")
public class CourseHomeworkController extends BaseController
{
    @Autowired
    private ICourseHomeworkService courseHomeworkService;

    /**
     * 查询课程作业列表
     */
    @ApiOperation("获取所有课程作业")
    @ApiImplicitParam(name = "courseHomework", value = "CourseHomework", required = true, dataType = "courseHomework")
    @PreAuthorize("@ss.hasPermi('system:homework:list')")
    @GetMapping("/list")
    public TableDataInfo list(CourseHomework courseHomework)
    {
        startPage();
        List<CourseHomework> list = courseHomeworkService.selectCourseHomeworkList(courseHomework);
        return getDataTable(list);
    }

    /**
     * 导出课程作业列表
     */
    @ApiOperation("导出课程作业列表")
    @ApiImplicitParam(name = "courseHomework", value = "CourseHomework", required = true, dataType = "courseHomework")
    @PreAuthorize("@ss.hasPermi('system:homework:export')")
    @Log(title = "课程作业管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CourseHomework courseHomework)
    {
        List<CourseHomework> list = courseHomeworkService.selectCourseHomeworkList(courseHomework);
        ExcelUtil<CourseHomework> util = new ExcelUtil<CourseHomework>(CourseHomework.class);
        util.exportExcel(response, list, "课程作业数据");
    }

    /**
     * 获取课程作业详细信息
     */
    @ApiOperation("获取课程作业详细信息")
    @ApiImplicitParam(name = "homeworkId", value = "Homework ID", required = true, dataType = "long", paramType = "path")
    @PreAuthorize("@ss.hasPermi('system:homework:query')")
    @GetMapping(value = "/{homeworkId}")
    public AjaxResult getInfo(@PathVariable("homeworkId") Long homeworkId)
    {
        return success(courseHomeworkService.selectCourseHomeworkByHomeworkId(homeworkId));
    }

    /**
     * 新增课程作业
     */
    @ApiOperation("新增课程作业")
    @ApiImplicitParam(name = "courseHomework", value = "CourseHomework", required = true, dataType = "courseHomework")
    @PreAuthorize("@ss.hasPermi('system:homework:add')")
    @Log(title = "课程作业管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CourseHomework courseHomework)
    {
        return toAjax(courseHomeworkService.insertCourseHomework(courseHomework));
    }

    /**
     * 修改课程作业
     */
    @ApiOperation("修改课程作业")
    @ApiImplicitParam(name = "courseHomework", value = "CourseHomework", required = true, dataType = "courseHomework")
    @PreAuthorize("@ss.hasPermi('system:homework:edit')")
    @Log(title = "课程作业管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CourseHomework courseHomework)
    {
        return toAjax(courseHomeworkService.updateCourseHomework(courseHomework));
    }

    /**
     * 删除课程作业
     */
    @ApiOperation("删除课程作业")
    @ApiImplicitParam(name = "homeworkIds", value = "Homework IDs", required = true, dataType = "array", paramType = "path")
    @PreAuthorize("@ss.hasPermi('system:homework:remove')")
    @Log(title = "课程作业管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{homeworkIds}")
    public AjaxResult remove(@PathVariable Long[] homeworkIds)
    {
        return toAjax(courseHomeworkService.deleteCourseHomeworkByHomeworkIds(homeworkIds));
    }
}