package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.core.redis.RedisCache;
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
 * @date 2024-11-11
 */
@RestController
@RequestMapping("/system/course_user")
public class CourseUserController extends BaseController
{
    @Autowired
    private ICourseUserService courseUserService;

    @Autowired
    private RedisCache redisCache;

    /**
     * 查询【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('system:courseUser:list')")
    @GetMapping("/list")
    public TableDataInfo list(CourseUser courseUser)
    {
        startPage();
        List<CourseUser> list = courseUserService.selectCourseUserList(courseUser);
        return getDataTable(list);
    }

    /**
     * 查询全部选课用户列表
     */
    @PreAuthorize("@ss.hasPermi('system:courseUser:stu_list')")
    @GetMapping("/userName_list")
    public TableDataInfo userName_list(CourseUser courseUser)
    {
        startPage();
        List<CourseUser> list = courseUserService.selectUserNameList(courseUser);
        return getDataTable(list);
    }

    /**
     * 查询其余学生列表
     */
    @PreAuthorize("@ss.hasPermi('system:courseUser:stu_list')")
    @GetMapping("/stu_list")
    public TableDataInfo stu_list(CourseUser courseUser)
    {
        startPage();
        List<CourseUser> list = courseUserService.selectOtherStuList(courseUser);
        return getDataTable(list);
    }

    /**
     * 导出【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('system:courseUser:export')")
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
    @PreAuthorize("@ss.hasPermi('system:courseUser:query')")
    @GetMapping(value = "/{courseId}")
    public AjaxResult getInfo(@PathVariable("courseId") Long courseId)
    {
        return success(courseUserService.selectCourseUserByCourseId(courseId));
    }

    /**
     * 新增【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:courseUser:add')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody List<CourseUser> courseUserList)
    {


        return toAjax(courseUserService.insertCourseUser(courseUserList));
    }

    /**
     * 修改【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:courseUser:edit')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CourseUser courseUser)
    {
        return toAjax(courseUserService.updateCourseUser(courseUser));
    }

    /**
     * 删除【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:courseUser:remove')")  // 权限验证
    @Log(title = "删除课程用户", businessType = BusinessType.DELETE)  // 日志记录
    @DeleteMapping("/{courseId}/{userId}")
    public AjaxResult remove(@PathVariable Long courseId, @PathVariable Long userId)
    {
        CourseUser courseUser = new CourseUser();
        courseUser.setCourseId(courseId);
        courseUser.setUserId(userId);
        return toAjax(courseUserService.deleteCourseUserByUserIds(courseUser));
    }
}
