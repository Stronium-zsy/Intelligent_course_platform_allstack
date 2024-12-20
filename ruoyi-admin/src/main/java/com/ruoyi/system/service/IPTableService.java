package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.PTable;

/**
 * 【请填写功能名称】Service接口
 * 
 * @author ruoyi
 * @date 2024-12-20
 */
public interface IPTableService 
{
    /**
     * 查询【请填写功能名称】
     * 
     * @param studentId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public PTable selectPTableByStudentId(String studentId);

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param pTable 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<PTable> selectPTableList(PTable pTable);

    /**
     * 新增【请填写功能名称】
     * 
     * @param pTable 【请填写功能名称】
     * @return 结果
     */
    public int insertPTable(PTable pTable);

    /**
     * 修改【请填写功能名称】
     * 
     * @param pTable 【请填写功能名称】
     * @return 结果
     */
    public int updatePTable(PTable pTable);

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param studentIds 需要删除的【请填写功能名称】主键集合
     * @return 结果
     */
    public int deletePTableByStudentIds(String[] studentIds);

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param studentId 【请填写功能名称】主键
     * @return 结果
     */
    public int deletePTableByStudentId(String studentId);
}
