package com.ruoyi.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.UserFavorites;
import com.ruoyi.system.service.IUserFavoritesService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 用户收藏Controller
 *
 * @author ruoyi
 * @date 2024-12-15
 */
@RestController
@RequestMapping("/system/favorites")
public class UserFavoritesController extends BaseController
{
    @Autowired
    private IUserFavoritesService userFavoritesService;

    /**
     * 查询用户收藏列表
     */
    @PreAuthorize("@ss.hasPermi('system:favorites:list')")
    @GetMapping("/list")
    public TableDataInfo list(UserFavorites userFavorites)
    {
        startPage();
        List<UserFavorites> list = userFavoritesService.selectUserFavoritesList(userFavorites);
        return getDataTable(list);
    }

    /**
     * 导出用户收藏列表
     */
    @PreAuthorize("@ss.hasPermi('system:favorites:export')")
    @Log(title = "用户收藏", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, UserFavorites userFavorites)
    {
        List<UserFavorites> list = userFavoritesService.selectUserFavoritesList(userFavorites);
        ExcelUtil<UserFavorites> util = new ExcelUtil<UserFavorites>(UserFavorites.class);
        util.exportExcel(response, list, "用户收藏数据");
    }

    /**
     * 获取用户收藏详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:favorites:query')")
    @GetMapping(value = "/{favoriteId}")
    public AjaxResult getInfo(@PathVariable("favoriteId") Long favoriteId)
    {
        return success(userFavoritesService.selectUserFavoritesByFavoriteId(favoriteId));
    }

    /**
     * 新增或取消收藏
     * 如果未收藏，则新增收藏记录并增加收藏数；
     * 如果已收藏，则删除收藏记录并减少收藏数。
     */
    @PreAuthorize("@ss.hasPermi('system:favorites:add')")
    @Log(title = "用户收藏", businessType = BusinessType.INSERT)
    @PostMapping("/toggle")
    public AjaxResult toggleFavorite(@RequestBody UserFavorites userFavorites) {
        try {
            boolean isFavorited = userFavoritesService.toggleFavorite(userFavorites);
            int favoritesCount = userFavoritesService.getFavoritesCountByPostId(userFavorites.getPostId()); // 获取最新收藏数
            Map<String, Object> response = new HashMap<>();
            response.put("isFavorited", isFavorited);
            response.put("favoritesCount", favoritesCount);
            return AjaxResult.success(response);
        } catch (Exception e) {
            return AjaxResult.error("操作失败：" + e.getMessage());
        }
    }


    /**
     * 修改用户收藏
     */
    @PreAuthorize("@ss.hasPermi('system:favorites:edit')")
    @Log(title = "用户收藏", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody UserFavorites userFavorites)
    {
        return toAjax(userFavoritesService.updateUserFavorites(userFavorites));
    }

    /**
     * 删除用户收藏
     */
    @PreAuthorize("@ss.hasPermi('system:favorites:remove')")
    @Log(title = "用户收藏", businessType = BusinessType.DELETE)
    @DeleteMapping("/{favoriteIds}")
    public AjaxResult remove(@PathVariable Long[] favoriteIds) {
        int result = userFavoritesService.deleteUserFavorites(favoriteIds);
        return toAjax(result);
    }

    @PreAuthorize("@ss.hasPermi('system:favorites:query')")
    @GetMapping("/listByCriteria")
    public TableDataInfo listByCriteria(UserFavorites userFavorites) {
        startPage(); // 分页
        List<UserFavorites> list = userFavoritesService.selectUserFavoritesByCriteria(userFavorites);
        return getDataTable(list);
    }


}
