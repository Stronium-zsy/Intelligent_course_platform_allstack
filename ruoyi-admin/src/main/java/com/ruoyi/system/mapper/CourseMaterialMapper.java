package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.CourseMaterial;

/**
 * 【请填写功能名称】Mapper接口
 * 
 * @author ruoyi
 * @date 2024-10-27
 */
public interface CourseMaterialMapper 
{
    /**
     * 查询【请填写功能名称】
     * 
     * @param materialId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public CourseMaterial selectCourseMaterialByMaterialId(Long materialId);

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param courseMaterial 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<CourseMaterial> selectCourseMaterialList(CourseMaterial courseMaterial);

    /**
     * 新增【请填写功能名称】
     * 
     * @param courseMaterial 【请填写功能名称】
     * @return 结果
     */
    public int insertCourseMaterial(CourseMaterial courseMaterial);

    /**
     * 修改【请填写功能名称】
     * 
     * @param courseMaterial 【请填写功能名称】
     * @return 结果
     */
    public int updateCourseMaterial(CourseMaterial courseMaterial);

    /**
     * 删除【请填写功能名称】
     * 
     * @param materialId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteCourseMaterialByMaterialId(Long materialId);

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param materialIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCourseMaterialByMaterialIds(Long[] materialIds);
}
