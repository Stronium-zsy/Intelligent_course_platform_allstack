package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.ScoresMapper;
import com.ruoyi.system.domain.Scores;
import com.ruoyi.system.service.IScoresService;

/**
 * 【请填写功能名称】Service业务层处理
 * 
 * @author ruoyi
 * @date 2024-12-20
 */
@Service
public class ScoresServiceImpl implements IScoresService 
{
    @Autowired
    private ScoresMapper scoresMapper;

    /**
     * 查询【请填写功能名称】
     * 
     * @param scorer 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public Scores selectScoresByScorer(String scorer)
    {
        return scoresMapper.selectScoresByScorer(scorer);
    }

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param scores 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<Scores> selectScoresList(Scores scores)
    {
        return scoresMapper.selectScoresList(scores);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param scores 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertScores(Scores scores)
    {
        return scoresMapper.insertScores(scores);
    }

    /**
     * 修改【请填写功能名称】
     * 
     * @param scores 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateScores(Scores scores)
    {
        return scoresMapper.updateScores(scores);
    }

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param scorers 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteScoresByScorers(String[] scorers)
    {
        return scoresMapper.deleteScoresByScorers(scorers);
    }

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param scorer 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteScoresByScorer(String scorer)
    {
        return scoresMapper.deleteScoresByScorer(scorer);
    }
}
