package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.Scores;

/**
 * 【请填写功能名称】Mapper接口
 * 
 * @author ruoyi
 * @date 2024-12-20
 */
public interface ScoresMapper 
{
    /**
     * 查询【请填写功能名称】
     * 
     * @param scorer 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    public Scores selectScoresByScorer(String scorer);

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param scores 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<Scores> selectScoresList(Scores scores);

    /**
     * 新增【请填写功能名称】
     * 
     * @param scores 【请填写功能名称】
     * @return 结果
     */
    public int insertScores(Scores scores);

    /**
     * 修改【请填写功能名称】
     * 
     * @param scores 【请填写功能名称】
     * @return 结果
     */
    public int updateScores(Scores scores);

    /**
     * 删除【请填写功能名称】
     * 
     * @param scorer 【请填写功能名称】主键
     * @return 结果
     */
    public int deleteScoresByScorer(String scorer);

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param scorers 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteScoresByScorers(String[] scorers);
}
