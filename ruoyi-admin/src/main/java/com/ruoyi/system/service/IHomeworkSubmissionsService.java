package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.HomeworkSubmissions;

/**
 * 【请填写功能名称】Service接口
 * 
 * @author ruoyi
 * @date 2024-10-27
 */
public interface IHomeworkSubmissionsService 
{
    /**
     * 查询【请填写功能名称】
     * 
     * @param submissionId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public HomeworkSubmissions selectHomeworkSubmissionsBySubmissionId(Long submissionId);

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param homeworkSubmissions 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<HomeworkSubmissions> selectHomeworkSubmissionsList(HomeworkSubmissions homeworkSubmissions);

    /**
     * 新增【请填写功能名称】
     * 
     * @param homeworkSubmissions 【请填写功能名称】
     * @return 结果
     */
    public int insertHomeworkSubmissions(HomeworkSubmissions homeworkSubmissions);

    /**
     * 修改【请填写功能名称】
     * 
     * @param homeworkSubmissions 【请填写功能名称】
     * @return 结果
     */
    public int updateHomeworkSubmissions(HomeworkSubmissions homeworkSubmissions);

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param submissionIds 需要删除的【请填写功能名称】主键集合
     * @return 结果
     */
    public int deleteHomeworkSubmissionsBySubmissionIds(Long[] submissionIds);

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param submissionId 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteHomeworkSubmissionsBySubmissionId(Long submissionId);
}
