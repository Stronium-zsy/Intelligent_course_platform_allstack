import request from '@/utils/request'

// 查询用户收藏列表
export function listFavorites(query) {
  return request({
    url: '/system/favorites/list',
    method: 'get',
    params: query
  })
}

// 查询用户收藏详细
export function getFavorites(favoriteId) {
  return request({
    url: '/system/favorites/' + favoriteId,
    method: 'get'
  })
}

// 新增用户收藏
export function addFavorites(data) {
  return request({
    url: '/system/favorites',
    method: 'post',
    data: data
  })
}

// 修改用户收藏
export function updateFavorites(data) {
  return request({
    url: '/system/favorites',
    method: 'put',
    data: data
  })
}

// 删除用户收藏
export function delFavorites(favoriteId) {
  return request({
    url: '/system/favorites/' + favoriteId,
    method: 'delete'
  })
}

// 新增或取消收藏
export function toggleFavorite(data) {
  return request({
    url: '/system/favorites/toggle',
    method: 'post',
    data: data
  })
}



// 查询用户收藏列表（支持用户名和时间）
export function listFavoritesByCriteria(query) {
  return request({
    url: '/system/favorites/listByCriteria',
    method: 'get',
    params: query,
  });
}


