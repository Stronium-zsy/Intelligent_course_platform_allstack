import request from '@/utils/request'

// 查询帖子列表
export function listPosts(query) {
  return request({
    url: '/system/posts/list',
    method: 'get',
    params: query
  })
}

// 查询帖子详细
export function getPosts(postId) {
  return request({
    url: '/system/posts/' + postId,
    method: 'get'
  })
}

// 新增帖子
export function addPosts(data) {
  return request({
    url: '/system/posts',
    method: 'post',
    data: data
  })
}

// 修改帖子
export function updatePosts(data) {
  return request({
    url: '/system/posts',
    method: 'put',
    data: data
  })
}

// 删除帖子
export function delPosts(postId) {
  return request({
    url: '/system/posts/' + postId,
    method: 'delete'
  })
}
