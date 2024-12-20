import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listScores(query) {
  return request({
    url: '/system/scores/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getScores(scorer) {
  return request({
    url: '/system/scores/' + scorer,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addScores(data) {
  return request({
    url: '/system/scores',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateScores(data) {
  return request({
    url: '/system/scores',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delScores(scorer) {
  return request({
    url: '/system/scores/' + scorer,
    method: 'delete'
  })
}
