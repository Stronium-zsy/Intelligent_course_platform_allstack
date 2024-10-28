package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
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
import com.ruoyi.system.domain.Courses;
import com.ruoyi.system.service.ICoursesService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 课程管理Controller
 *
 * @date 2024-10-27
 */
@Api("课程管理")
@RestController
@RequestMapping("/system/courses")
public class CoursesController extends BaseController
{
    @Autowired
    private ICoursesService coursesService;

    /**
     * 查询课程列表
     */
    @ApiOperation("获取所有课程")
    @ApiImplicitParam(name = "courses", value = "Courses", required = true, dataType = "course")
    @PreAuthorize("@ss.hasPermi('system:courses:list')")
    @GetMapping("/list")
    public TableDataInfo list(Courses courses)
    {
        startPage();
        List<Courses> list = coursesService.selectCoursesList(courses);
        return getDataTable(list);
    }

    /**
     * 导出课程列表
     */
    @ApiOperation("导出课程列表")
    @ApiImplicitParam(name = "courses", value = "Courses", required = true, dataType = "course")
    @PreAuthorize("@ss.hasPermi('system:courses:export')")
    @Log(title = "课程管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Courses courses) {
        List<Courses> list = coursesService.selectCoursesList(courses);
        ExcelUtil<Courses> util = new ExcelUtil<Courses>(Courses.class);
        util.exportExcel(response, list, "课程数据");
    }

    /**
     * 获取课程详细信息
     */
    @ApiOperation("获取课程详细信息")
    @ApiImplicitParam(name = "courseId", value = "Course ID", required = true, dataType = "long", paramType = "path")
    @PreAuthorize("@ss.hasPermi('system:courses:query')")
    @GetMapping(value = "/{courseId}")
    public AjaxResult getInfo(@PathVariable("courseId") Long courseId)
    {
        return success(coursesService.selectCoursesByCourseId(courseId));
    }

    /**
     * 新增课程
     */
    @ApiOperation("新增课程")
    @ApiImplicitParam(name = "courses", value = "Courses", required = true, dataType = "course")
    @PreAuthorize("@ss.hasPermi('system:courses:add')")
    @Log(title = "课程管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Courses courses)
    {
        return toAjax(coursesService.insertCourses(courses));
    }

    /**
     * 修改课程
     */
    @ApiOperation("修改课程")
    @ApiImplicitParam(name = "courses", value = "Courses", required = true, dataType = "course")
    @PreAuthorize("@ss.hasPermi('system:courses:edit')")
    @Log(title = "课程管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Courses courses)
    {
        return toAjax(coursesService.updateCourses(courses));
    }

    /**
     * 删除课程
     */
    @ApiOperation("删除课程")
    @ApiImplicitParam(name = "courseIds", value = "Course IDs", required = true, dataType = "array", paramType = "path")
    @PreAuthorize("@ss.hasPermi('system:courses:remove')")
    @Log(title = "课程管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{courseIds}")
    public AjaxResult remove(@PathVariable Long[] courseIds)
    {
        return toAjax(coursesService.deleteCoursesByCourseIds(courseIds));
    }
}