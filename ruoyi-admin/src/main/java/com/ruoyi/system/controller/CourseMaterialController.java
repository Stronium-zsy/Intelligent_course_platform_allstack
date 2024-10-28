package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import com.mongodb.client.gridfs.GridFSBucket;
import com.mongodb.client.gridfs.model.GridFSUploadOptions;
import io.swagger.annotations.ApiImplicitParams;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.CourseMaterial;
import com.ruoyi.system.service.ICourseMaterialService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;
import org.springframework.web.multipart.MultipartFile;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;

/**
 * 课程资料管理Controller
 *
 * @date 2024-10-27
 */
@Api("课程资料管理")
@RestController
@RequestMapping("/system/course_material")
public class CourseMaterialController extends BaseController
{
    @Autowired
    private ICourseMaterialService courseMaterialService;

    /**
     * 查询课程资料列表
     */
    @ApiOperation("获取所有课程资料")
    @ApiImplicitParam(name = "courseMaterial", value = "CourseMaterial", required = true, dataType = "CourseMaterial")
    @PreAuthorize("@ss.hasPermi('system:material:list')")
    @GetMapping("/list")
    public TableDataInfo list(CourseMaterial courseMaterial)
    {
        startPage();
        List<CourseMaterial> list = courseMaterialService.selectCourseMaterialList(courseMaterial);
        return getDataTable(list);
    }

    /**
     * 导出课程资料列表
     */
    @ApiOperation("导出课程资料列表")
    @ApiImplicitParam(name = "courseMaterial", value = "CourseMaterial", required = true, dataType = "CourseMaterial")
    @PreAuthorize("@ss.hasPermi('system:material:export')")
    @Log(title = "课程资料管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CourseMaterial courseMaterial)
    {
        List<CourseMaterial> list = courseMaterialService.selectCourseMaterialList(courseMaterial);
        ExcelUtil<CourseMaterial> util = new ExcelUtil<CourseMaterial>(CourseMaterial.class);
        util.exportExcel(response, list, "课程资料数据");
    }

    /**
     * 获取课程资料详细信息
     */
    @ApiOperation("获取课程资料详细信息")
    @ApiImplicitParam(name = "materialId", value = "Material ID", required = true, dataType = "long", paramType = "path")
    @PreAuthorize("@ss.hasPermi('system:material:query')")
    @GetMapping(value = "/{materialId}")
    public AjaxResult getInfo(@PathVariable("materialId") Long materialId)
    {
        return success(courseMaterialService.selectCourseMaterialByMaterialId(materialId));
    }

    /**
     * 新增课程资料
     */
    @ApiImplicitParams({
        @ApiImplicitParam(name = "file", value = "File", required = true, dataType = "MultipartFile", paramType = "form"),
    @ApiImplicitParam(name = "courseId", value = "Course ID", required = true, dataType = "long", paramType = "form")
    })
    @PreAuthorize("@ss.hasPermi('system:material:add')")
    @Log(title = "课程资料", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestParam("file") MultipartFile file, @RequestParam("courseId") Long courseId) {
        try {
            // 将文件上传和数据库保存交给 Service 层处理
            int result = courseMaterialService.insertCourseMaterial(file, courseId);
            return toAjax(result);
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.error("文件上传失败：" + e.getMessage());
        }
    }

    /**
     * 修改课程资料
     */
    @ApiOperation("修改课程资料")
    @ApiImplicitParam(name = "courseMaterial", value = "CourseMaterial", required = true, dataType = "CourseMaterial")
    @PreAuthorize("@ss.hasPermi('system:material:edit')")
    @Log(title = "课程资料管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CourseMaterial courseMaterial)
    {
        return toAjax(courseMaterialService.updateCourseMaterial(courseMaterial));
    }

    /**
     * 删除课程资料
     */
    @ApiOperation("删除课程资料")
    @ApiImplicitParam(name = "materialIds", value = "Material IDs", required = true, dataType = "array", paramType = "path")
    @PreAuthorize("@ss.hasPermi('system:material:remove')")
    @Log(title = "课程资料管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{materialIds}")
    public AjaxResult remove(@PathVariable Long[] materialIds)
    {
        return toAjax(courseMaterialService.deleteCourseMaterialByMaterialIds(materialIds));
    }
}