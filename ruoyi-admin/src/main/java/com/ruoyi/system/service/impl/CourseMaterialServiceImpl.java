package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.CourseMaterialMapper;
import com.ruoyi.system.domain.CourseMaterial;
import com.ruoyi.system.service.ICourseMaterialService;

/**
 * 【请填写功能名称】Service业务层处理
 * 
 * @author ruoyi
 * @date 2024-11-11
 */
@Service
public class CourseMaterialServiceImpl implements ICourseMaterialService 
{
    @Autowired
    private CourseMaterialMapper courseMaterialMapper;

    /**
     * 查询【请填写功能名称】
     * 
     * @param materialId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public CourseMaterial selectCourseMaterialByMaterialId(Long materialId)
    {
        return courseMaterialMapper.selectCourseMaterialByMaterialId(materialId);
    }

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param courseMaterial 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<CourseMaterial> selectCourseMaterialList(CourseMaterial courseMaterial)
    {
        return courseMaterialMapper.selectCourseMaterialList(courseMaterial);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param courseMaterial 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertCourseMaterial(CourseMaterial courseMaterial)
    {
        return courseMaterialMapper.insertCourseMaterial(courseMaterial);
    }

    /**
     * 修改【请填写功能名称】
     * 
     * @param courseMaterial 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateCourseMaterial(CourseMaterial courseMaterial)
    {
        return courseMaterialMapper.updateCourseMaterial(courseMaterial);
    }

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param materialIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteCourseMaterialByMaterialIds(Long[] materialIds)
    {
        return courseMaterialMapper.deleteCourseMaterialByMaterialIds(materialIds);
    }

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param materialId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteCourseMaterialByMaterialId(Long materialId)
    {
        return courseMaterialMapper.deleteCourseMaterialByMaterialId(materialId);
    }
}
