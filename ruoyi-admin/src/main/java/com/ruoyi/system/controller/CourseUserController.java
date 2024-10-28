package com.ruoyi.system.controller;

import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.system.domain.Courses;
import com.ruoyi.system.service.ICoursesService;
import com.ruoyi.system.service.ISysUserService;
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
import com.ruoyi.system.domain.CourseUser;
import com.ruoyi.system.service.ICourseUserService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiImplicitParam;
/**
 * 课程用户管理Controller
 *
 * @date 2024-10-27
 */
@RestController
@RequestMapping("/system/course_user")
public class CourseUserController extends BaseController
{
    @Autowired
    private ICourseUserService courseUserService;

    @Autowired
    private ICoursesService courseService;

    @Autowired
    private ISysUserService userService;

    /**
     * 查询课程用户列表
     */
    @ApiOperation("获取所有课程用户")
    @ApiImplicitParam(name = "courseUser", value = "CourseUser", required = true, dataType = "courseUser")
    @PreAuthorize("@ss.hasPermi('system:user:list')")
    @GetMapping("/list")
    public TableDataInfo list(CourseUser courseUser)
    {
        startPage();
        List<CourseUser> list = courseUserService.selectCourseUserList(courseUser);
        return getDataTable(list);
    }

    /**
     * 导出课程用户列表
     */
    @ApiOperation("导出课程用户列表")
    @ApiImplicitParam(name = "courseUser", value = "CourseUser", required = true, dataType = "courseUser")
    @PreAuthorize("@ss.hasPermi('system:user:export')")
    @Log(title = "课程用户管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CourseUser courseUser)
    {
        List<CourseUser> list = courseUserService.selectCourseUserList(courseUser);
        ExcelUtil<CourseUser> util = new ExcelUtil<CourseUser>(CourseUser.class);
        util.exportExcel(response, list, "课程用户数据");
    }

    /**
     * 获取课程用户详细信息
     */
    @ApiOperation("获取课程用户详细信息")
    @ApiImplicitParam(name = "courseId", value = "Course ID", required = true, dataType = "long", paramType = "path")
    @PreAuthorize("@ss.hasPermi('system:user:query')")
    @GetMapping(value = "/course/{courseId}")
    public AjaxResult getCourseInfo(@PathVariable("courseId") Long courseId)
    {
        List<CourseUser> courseUsers = courseUserService.selectCourseUserByCourseId(courseId);
        List<Long> userIds = courseUsers.stream()
                .map(CourseUser::getUserId)
                .collect(Collectors.toList());

        List<SysUser> users = userIds.stream()
                .map(userService::selectUserById)
                .collect(Collectors.toList());

        return AjaxResult.success(users);
    }

    /**
     * 获取课程用户详细信息
     */
    @ApiOperation("获取课程用户详细信息")
    @ApiImplicitParam(name = "userId", value = "User ID", required = true, dataType = "long", paramType = "path")
    @PreAuthorize("@ss.hasPermi('system:user:query')")
    @GetMapping(value = "/user/{userId}")
    public AjaxResult getUserInfo(@PathVariable("userId") Long userId)
    {
        List<CourseUser> courseUsers = courseUserService.selectCourseUserByUserId(userId);
        List<Long> courseIds = courseUsers.stream()
                .map(CourseUser::getCourseId)
                .collect(Collectors.toList());

        List<Courses> courses = courseIds.stream()
                .map(courseService::selectCoursesByCourseId)
                .collect(Collectors.toList());

        return AjaxResult.success(courses);
    }

    /**
     * 新增课程用户
     */
    @ApiOperation("新增课程用户")
    @ApiImplicitParam(name = "courseUser", value = "CourseUser", required = true, dataType = "courseUser")
    @PreAuthorize("@ss.hasPermi('system:user:add')")
    @Log(title = "课程用户管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CourseUser courseUser)
    {
        return toAjax(courseUserService.insertCourseUser(courseUser));
    }

    /**
     * 修改课程用户
     */
    @ApiOperation("修改课程用户")
    @ApiImplicitParam(name = "courseUser", value = "CourseUser", required = true, dataType = "courseUser")
    @PreAuthorize("@ss.hasPermi('system:user:edit')")
    @Log(title = "课程用户管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CourseUser courseUser)
    {
        return toAjax(courseUserService.updateCourseUser(courseUser));
    }

    /**
     * 删除课程用户
     */
    @ApiOperation("删除课程用户")
    @ApiImplicitParam(name = "courseIds", value = "Course IDs", required = true, dataType = "array", paramType = "path")
    @PreAuthorize("@ss.hasPermi('system:user:remove')")
    @Log(title = "课程用户管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{courseIds}")
    public AjaxResult remove(@PathVariable Long[] courseIds)
    {
        return toAjax(courseUserService.deleteCourseUserByCourseIds(courseIds));
    }
}