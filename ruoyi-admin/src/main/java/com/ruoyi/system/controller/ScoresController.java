package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.system.domain.HomeworkSubmissions;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.Scores;
import com.ruoyi.system.service.IScoresService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 【请填写功能名称】Controller
 * 
 * @author ruoyi
 * @date 2024-12-20
 */
@RestController
@RequestMapping("/system/scores")
public class ScoresController extends BaseController
{
    @Autowired
    private IScoresService scoresService;

    /**
     * 查询【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('system:scores:list')")
    @GetMapping("/list")
    public TableDataInfo list(Scores scores)
    {
        startPage();
        List<Scores> list = scoresService.selectScoresList(scores);
        return getDataTable(list);
    }

    /**
     * 导出【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('system:scores:export')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Scores scores)
    {
        List<Scores> list = scoresService.selectScoresList(scores);
        ExcelUtil<Scores> util = new ExcelUtil<Scores>(Scores.class);
        util.exportExcel(response, list, "【请填写功能名称】数据");
    }

    /**
     * 获取【请填写功能名称】详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:scores:query')")
    @GetMapping(value = "/{scorer}")
    public AjaxResult getInfo(@PathVariable("scorer") String scorer)
    {
        return success(scoresService.selectScoresByScorer(scorer));
    }

    /**
     * 新增【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:scores:add')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Scores scores)
    {
        return toAjax(scoresService.insertScores(scores));
    }

    /**
     * 修改【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:scores:edit')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Scores scores)
    {
        return toAjax(scoresService.updateScores(scores));
    }

    /**
     * 删除【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:scores:remove')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.DELETE)
	@DeleteMapping("/{scorers}")
    public AjaxResult remove(@PathVariable String[] scorers)
    {
        return toAjax(scoresService.deleteScoresByScorers(scorers));
    }


    @GetMapping("/reviewTasks")
    public AjaxResult getReviewTasks(@RequestParam Long judger) {
        try {
            List<HomeworkSubmissions> reviewTasks = scoresService.getReviewTasksByJudger(judger);
            return AjaxResult.success(reviewTasks);
        } catch (Exception e) {
            return AjaxResult.error("获取需要批改的作业失败：" + e.getMessage());
        }
    }
}
