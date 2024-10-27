package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.HomeworkSubmissionsMapper;
import com.ruoyi.system.domain.HomeworkSubmissions;
import com.ruoyi.system.service.IHomeworkSubmissionsService;

/**
 * 【请填写功能名称】Service业务层处理
 * 
 * @author ruoyi
 * @date 2024-10-27
 */
@Service
public class HomeworkSubmissionsServiceImpl implements IHomeworkSubmissionsService 
{
    @Autowired
    private HomeworkSubmissionsMapper homeworkSubmissionsMapper;

    /**
     * 查询【请填写功能名称】
     * 
     * @param submissionId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public HomeworkSubmissions selectHomeworkSubmissionsBySubmissionId(Long submissionId)
    {
        return homeworkSubmissionsMapper.selectHomeworkSubmissionsBySubmissionId(submissionId);
    }

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param homeworkSubmissions 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<HomeworkSubmissions> selectHomeworkSubmissionsList(HomeworkSubmissions homeworkSubmissions)
    {
        return homeworkSubmissionsMapper.selectHomeworkSubmissionsList(homeworkSubmissions);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param homeworkSubmissions 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertHomeworkSubmissions(HomeworkSubmissions homeworkSubmissions)
    {
        return homeworkSubmissionsMapper.insertHomeworkSubmissions(homeworkSubmissions);
    }

    /**
     * 修改【请填写功能名称】
     * 
     * @param homeworkSubmissions 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateHomeworkSubmissions(HomeworkSubmissions homeworkSubmissions)
    {
        return homeworkSubmissionsMapper.updateHomeworkSubmissions(homeworkSubmissions);
    }

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param submissionIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteHomeworkSubmissionsBySubmissionIds(Long[] submissionIds)
    {
        return homeworkSubmissionsMapper.deleteHomeworkSubmissionsBySubmissionIds(submissionIds);
    }

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param submissionId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteHomeworkSubmissionsBySubmissionId(Long submissionId)
    {
        return homeworkSubmissionsMapper.deleteHomeworkSubmissionsBySubmissionId(submissionId);
    }
}
