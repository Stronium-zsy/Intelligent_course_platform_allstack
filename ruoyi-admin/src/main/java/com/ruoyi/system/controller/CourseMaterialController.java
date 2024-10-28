package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import com.mongodb.client.gridfs.GridFSBucket;
import com.mongodb.client.gridfs.model.GridFSUploadOptions;
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

/**
 * 【请填写功能名称】Controller
 * 
 * @author ruoyi
 * @date 2024-10-27
 */
@RestController
@RequestMapping("/system/course_material")
public class CourseMaterialController extends BaseController
{
    @Autowired
    private ICourseMaterialService courseMaterialService;



    /**
     * 查询【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('system:material:list')")
    @GetMapping("/list")
    public TableDataInfo list(CourseMaterial courseMaterial)
    {
        startPage();
        List<CourseMaterial> list = courseMaterialService.selectCourseMaterialList(courseMaterial);
        return getDataTable(list);
    }

    /**
     * 导出【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('system:material:export')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CourseMaterial courseMaterial)
    {
        List<CourseMaterial> list = courseMaterialService.selectCourseMaterialList(courseMaterial);
        ExcelUtil<CourseMaterial> util = new ExcelUtil<CourseMaterial>(CourseMaterial.class);
        util.exportExcel(response, list, "【请填写功能名称】数据");
    }

    /**
     * 获取【请填写功能名称】详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:material:query')")
    @GetMapping(value = "/{materialId}")
    public AjaxResult getInfo(@PathVariable("materialId") Long materialId)
    {
        return success(courseMaterialService.selectCourseMaterialByMaterialId(materialId));
    }

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
     * 修改【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:material:edit')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CourseMaterial courseMaterial)
    {
        return toAjax(courseMaterialService.updateCourseMaterial(courseMaterial));
    }

    /**
     * 删除【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:material:remove')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.DELETE)
	@DeleteMapping("/{materialIds}")
    public AjaxResult remove(@PathVariable Long[] materialIds)
    {
        return toAjax(courseMaterialService.deleteCourseMaterialByMaterialIds(materialIds));
    }
}
