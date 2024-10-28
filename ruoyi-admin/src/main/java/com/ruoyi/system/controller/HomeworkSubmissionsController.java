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
import com.ruoyi.system.domain.HomeworkSubmissions;
import com.ruoyi.system.service.IHomeworkSubmissionsService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;

/**
 * 作业提交管理Controller
 *
 * @date 2024-10-27
 */
@Api("作业提交管理")
@RestController
@RequestMapping("/system/homework_submissions")
public class HomeworkSubmissionsController extends BaseController
{
    @Autowired
    private IHomeworkSubmissionsService homeworkSubmissionsService;

    /**
     * 查询作业提交列表
     */
    @ApiOperation("获取所有作业提交")
    @ApiImplicitParam(name = "homeworkSubmissions", value = "HomeworkSubmissions", required = true, dataType = "homeworkSubmissions")
    @PreAuthorize("@ss.hasPermi('system:submissions:list')")
    @GetMapping("/list")
    public TableDataInfo list(HomeworkSubmissions homeworkSubmissions)
    {
        startPage();
        List<HomeworkSubmissions> list = homeworkSubmissionsService.selectHomeworkSubmissionsList(homeworkSubmissions);
        return getDataTable(list);
    }

    /**
     * 导出作业提交列表
     */
    @ApiOperation("导出作业提交列表")
    @ApiImplicitParam(name = "homeworkSubmissions", value = "HomeworkSubmissions", required = true, dataType = "homeworkSubmissions")
    @PreAuthorize("@ss.hasPermi('system:submissions:export')")
    @Log(title = "作业提交管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, HomeworkSubmissions homeworkSubmissions)
    {
        List<HomeworkSubmissions> list = homeworkSubmissionsService.selectHomeworkSubmissionsList(homeworkSubmissions);
        ExcelUtil<HomeworkSubmissions> util = new ExcelUtil<HomeworkSubmissions>(HomeworkSubmissions.class);
        util.exportExcel(response, list, "作业提交数据");
    }

    /**
     * 获取作业提交详细信息
     */
    @ApiOperation("获取作业提交详细信息")
    @ApiImplicitParam(name = "submissionId", value = "Submission ID", required = true, dataType = "long", paramType = "path")
    @PreAuthorize("@ss.hasPermi('system:submissions:query')")
    @GetMapping(value = "/{submissionId}")
    public AjaxResult getInfo(@PathVariable("submissionId") Long submissionId)
    {
        return success(homeworkSubmissionsService.selectHomeworkSubmissionsBySubmissionId(submissionId));
    }

    /**
     * 新增作业提交
     */
    @ApiOperation("新增作业提交")
    @ApiImplicitParam(name = "homeworkSubmissions", value = "HomeworkSubmissions", required = true, dataType = "homeworkSubmissions")
    @PreAuthorize("@ss.hasPermi('system:submissions:add')")
    @Log(title = "作业提交管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody HomeworkSubmissions homeworkSubmissions)
    {
        return toAjax(homeworkSubmissionsService.insertHomeworkSubmissions(homeworkSubmissions));
    }

    /**
     * 修改作业提交
     */
    @ApiOperation("修改作业提交")
    @ApiImplicitParam(name = "homeworkSubmissions", value = "HomeworkSubmissions", required = true, dataType = "homeworkSubmissions")
    @PreAuthorize("@ss.hasPermi('system:submissions:edit')")
    @Log(title = "作业提交管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody HomeworkSubmissions homeworkSubmissions)
    {
        return toAjax(homeworkSubmissionsService.updateHomeworkSubmissions(homeworkSubmissions));
    }

    /**
     * 删除作业提交
     */
    @ApiOperation("删除作业提交")
    @ApiImplicitParam(name = "submissionIds", value = "Submission IDs", required = true, dataType = "array", paramType = "path")
    @PreAuthorize("@ss.hasPermi('system:submissions:remove')")
    @Log(title = "作业提交管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{submissionIds}")
    public AjaxResult remove(@PathVariable Long[] submissionIds)
    {
        return toAjax(homeworkSubmissionsService.deleteHomeworkSubmissionsBySubmissionIds(submissionIds));
    }
}