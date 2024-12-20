package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.PTableMapper;
import com.ruoyi.system.domain.PTable;
import com.ruoyi.system.service.IPTableService;

/**
 * 【请填写功能名称】Service业务层处理
 * 
 * @author ruoyi
 * @date 2024-12-20
 */
@Service
public class PTableServiceImpl implements IPTableService 
{
    @Autowired
    private PTableMapper pTableMapper;

    /**
     * 查询【请填写功能名称】
     * 
     * @param studentId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public PTable selectPTableByStudentId(String studentId)
    {
        return pTableMapper.selectPTableByStudentId(studentId);
    }

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param pTable 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<PTable> selectPTableList(PTable pTable)
    {
        return pTableMapper.selectPTableList(pTable);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param pTable 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertPTable(PTable pTable)
    {
        return pTableMapper.insertPTable(pTable);
    }

    /**
     * 修改【请填写功能名称】
     * 
     * @param pTable 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updatePTable(PTable pTable)
    {
        return pTableMapper.updatePTable(pTable);
    }

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param studentIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deletePTableByStudentIds(String[] studentIds)
    {
        return pTableMapper.deletePTableByStudentIds(studentIds);
    }

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param studentId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deletePTableByStudentId(String studentId)
    {
        return pTableMapper.deletePTableByStudentId(studentId);
    }
}
