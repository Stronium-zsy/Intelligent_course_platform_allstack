package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.util.CourseDiscussionUtil;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.DiscussionMessage;
import com.ruoyi.system.service.IDiscussionMessageService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 【请填写功能名称】Controller
 * 
 * @author ruoyi
 * @date 2024-11-20
 */
@RestController
@RequestMapping("/system/message")
public class DiscussionMessageController extends BaseController
{
    @Autowired
    private IDiscussionMessageService discussionMessageService;

    @Autowired
    private CourseDiscussionUtil courseDiscussionUtil;

    /**
     * 查询【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('system:message:list')")
    @GetMapping("/list")
    public TableDataInfo list(DiscussionMessage discussionMessage)
    {
        startPage();
        List<DiscussionMessage> list = discussionMessageService.selectDiscussionMessageList(discussionMessage);
        return getDataTable(list);
    }

    /**
     * 导出【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('system:message:export')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, DiscussionMessage discussionMessage)
    {
        List<DiscussionMessage> list = discussionMessageService.selectDiscussionMessageList(discussionMessage);
        ExcelUtil<DiscussionMessage> util = new ExcelUtil<DiscussionMessage>(DiscussionMessage.class);
        util.exportExcel(response, list, "【请填写功能名称】数据");
    }

    /**
     * 获取【请填写功能名称】详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:message:query')")
    @GetMapping(value = "/{messageId}")
    public AjaxResult getInfo(@PathVariable("messageId") Long messageId)
    {
        return success(discussionMessageService.selectDiscussionMessageByMessageId(messageId));
    }

    /**
     * 新增【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:message:add')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody DiscussionMessage discussionMessage)
    {
        courseDiscussionUtil.publishChannelMessage(discussionMessage.getCourseId(), discussionMessage.getMessageDetail());

        discussionMessage.setUserId(SecurityUtils.getUserId());
        discussionMessage.setUserName(SecurityUtils.getUsername());
        return toAjax(discussionMessageService.insertDiscussionMessage(discussionMessage));
    }

    /**
     * 修改【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:message:edit')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody DiscussionMessage discussionMessage)
    {
        return toAjax(discussionMessageService.updateDiscussionMessage(discussionMessage));
    }

    /**
     * 删除【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:message:remove')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.DELETE)
	@DeleteMapping("/{messageIds}")
    public AjaxResult remove(@PathVariable Long[] messageIds)
    {
        return toAjax(discussionMessageService.deleteDiscussionMessageByMessageIds(messageIds));
    }
}
