import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listTable(query) {
  return request({
    url: '/system/table/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getTable(studentId) {
  return request({
    url: '/system/table/' + studentId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addTable(data) {
  return request({
    url: '/system/table',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateTable(data) {
  return request({
    url: '/system/table',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delTable(studentId) {
  return request({
    url: '/system/table/' + studentId,
    method: 'delete'
  })
}
