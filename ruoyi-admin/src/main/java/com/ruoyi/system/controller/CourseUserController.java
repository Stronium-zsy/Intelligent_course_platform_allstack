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

/**
 * 【请填写功能名称】Controller
 * 
 * @author ruoyi
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
     * 查询【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('system:user:list')")
    @GetMapping("/list")
    public TableDataInfo list(CourseUser courseUser)
    {
        startPage();
        List<CourseUser> list = courseUserService.selectCourseUserList(courseUser);
        return getDataTable(list);
    }

    /**
     * 导出【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('system:user:export')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CourseUser courseUser)
    {
        List<CourseUser> list = courseUserService.selectCourseUserList(courseUser);
        ExcelUtil<CourseUser> util = new ExcelUtil<CourseUser>(CourseUser.class);
        util.exportExcel(response, list, "【请填写功能名称】数据");
    }

    /**
     * 获取【请填写功能名称】详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:user:query')")
    @GetMapping(value = "/course/{courseId}")
    public AjaxResult getCourseInfo(@PathVariable("courseId") Long courseId)
    {

        List<CourseUser> courseUsers = courseUserService.selectCourseUserByCourseId(courseId); // 获取所有 CourseUser 列表>
        List<Long> userIds = courseUsers.stream()
                .map(CourseUser::getUserId)
                .collect(Collectors.toList()); // 提取 userId 列表

        List<SysUser> users = userIds.stream()
                .map(userService::selectUserById)
                .collect(Collectors.toList());

        return AjaxResult.success(users);
    }

    /**
     * 获取【请填写功能名称】详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:user:query')")
    @GetMapping(value = "/user/{userId}")
    public AjaxResult getUserInfo(@PathVariable("userId") Long userId)
    {
        // 获取所有 CourseUser 列表
        List<CourseUser> courseUsers = courseUserService.selectCourseUserByUserId(userId);

        // 提取 courseId 列表
        List<Long> courseIds = courseUsers.stream()
                .map(CourseUser::getCourseId)
                .collect(Collectors.toList());

        // 根据 courseId 获取每门课程的详细信息
        List<Courses> courses = courseIds.stream()
                .map(courseService::selectCoursesByCourseId)
                .collect(Collectors.toList());

        return AjaxResult.success(courses);
    }

    /**
     * 新增【请填写功能名称】
     */
    //先查找，再添加
    @PreAuthorize("@ss.hasPermi('system:user:add')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CourseUser courseUser)
    {
        return toAjax(courseUserService.insertCourseUser(courseUser));
    }

    /**
     * 修改【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:user:edit')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CourseUser courseUser)
    {
        return toAjax(courseUserService.updateCourseUser(courseUser));
    }

    /**
     * 删除【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:user:remove')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.DELETE)
	@DeleteMapping("/{courseIds}")
    public AjaxResult remove(@PathVariable Long[] courseIds)
    {
        return toAjax(courseUserService.deleteCourseUserByCourseIds(courseIds));
    }
}
