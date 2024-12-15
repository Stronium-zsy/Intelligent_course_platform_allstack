package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.FileUtils;
import com.ruoyi.framework.config.ServerConfig;
import com.ruoyi.system.domain.HomeworkSubmissions;
import org.springframework.beans.factory.annotation.Value;
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
import com.ruoyi.system.domain.CourseHomework;
import com.ruoyi.system.service.ICourseHomeworkService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;
import org.springframework.web.multipart.MultipartFile;

/**
 * 【请填写功能名称】Controller
 * 
 * @author ruoyi
 * @date 2024-11-11
 */
@RestController
@RequestMapping("/system/homework")
public class CourseHomeworkController extends BaseController
{
    @Autowired
    private ICourseHomeworkService courseHomeworkService;

    @Autowired
    private ServerConfig serverConfig;

    @Value("${ruoyi.profile}")
    private String uploadPath;

    /**
     * 查询【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('system:homework:query')")
    @GetMapping("/list")
    public TableDataInfo list(CourseHomework courseHomework)
    {
        startPage();
        List<CourseHomework> list = courseHomeworkService.selectCourseHomeworkList(courseHomework);
        return getDataTable(list);
    }

    /**
     * 导出【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('system:homework:export')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CourseHomework courseHomework)
    {
        List<CourseHomework> list = courseHomeworkService.selectCourseHomeworkList(courseHomework);
        ExcelUtil<CourseHomework> util = new ExcelUtil<CourseHomework>(CourseHomework.class);
        util.exportExcel(response, list, "【请填写功能名称】数据");
    }

    /**
     * 获取【请填写功能名称】详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:homework:query')")
    @GetMapping(value = "/{homeworkId}")
    public AjaxResult getInfo(@PathVariable("homeworkId") Long homeworkId)
    {
        return success(courseHomeworkService.selectCourseHomeworkByHomeworkId(homeworkId));
    }

    /**
     * 新增【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:homework:add')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CourseHomework courseHomework)
    {
        return toAjax(courseHomeworkService.insertCourseHomework(courseHomework));
    }

    /**
     * 修改【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:homework:edit')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CourseHomework courseHomework)
    {
        return toAjax(courseHomeworkService.updateCourseHomework(courseHomework));
    }

    @PreAuthorize("@ss.hasPermi('system:submissions:add')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.EXPORT)
    @PostMapping("/updateHomework")
    public AjaxResult uploadFile(MultipartFile file,CourseHomework courseHomework) throws Exception
    {
        try
        {
            Boolean isValid = courseHomeworkService.selectCourseHomeworkList(courseHomework).stream().noneMatch(hs -> hs.getHomeworkId().equals(courseHomework.getHomeworkId()));
            String fileName = FileUploadUtils.upload(
                    uploadPath
                    + "/homeworks/"+courseHomework.getCourseId()+"/homeworkId/"+courseHomework.getHomeworkId()
                    , file);
            String url = serverConfig.getUrl() + fileName;
            courseHomework.setFilePath(fileName);
            AjaxResult ajax = AjaxResult.success();
            ajax.put("url", url);
            ajax.put("fileName", fileName);
            ajax.put("newFileName", FileUtils.getName(fileName));
            ajax.put("originalFilename", file.getOriginalFilename());
            System.out.println(courseHomework);
            if (isValid) {
                ajax.put("insertResult",courseHomeworkService.insertCourseHomework(courseHomework));
            }else{
                ajax.put("updateResult",courseHomeworkService.updateCourseHomework(courseHomework));
            }
            return ajax;
        }
        catch (Exception e)
        {
            return AjaxResult.error(e.getMessage());
        }
    }

    /**
     * 删除【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:homework:remove')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.DELETE)
	@DeleteMapping("/{homeworkIds}")
    public AjaxResult remove(@PathVariable Long[] homeworkIds)
    {
        return toAjax(courseHomeworkService.deleteCourseHomeworkByHomeworkIds(homeworkIds));
    }
}
