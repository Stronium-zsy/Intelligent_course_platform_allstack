import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listPosts(query) {
  return request({
    url: '/system/posts/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getPosts(postId) {
  return request({
    url: '/system/posts/' + postId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addPosts(data) {
  return request({
    url: '/system/posts',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updatePosts(data) {
  return request({
    url: '/system/posts',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delPosts(postId) {
  return request({
    url: '/system/posts/' + postId,
    method: 'delete'
  })
}
