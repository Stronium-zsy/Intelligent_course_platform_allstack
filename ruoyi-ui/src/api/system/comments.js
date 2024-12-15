import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listComments(query) {
  return request({
    url: '/system/comments/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getComments(commentId) {
  return request({
    url: '/system/comments/' + commentId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addComments(data) {
  return request({
    url: '/system/comments',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateComments(data) {
  return request({
    url: '/system/comments',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delComments(commentId) {
  return request({
    url: '/system/comments/' + commentId,
    method: 'delete'
  })
}
