import request from '../../../../../Intelligent_course_platform/ruoyi-ui/src/utils/request'

// 查询【请填写功能名称】列表
export function listMaterial(query) {
  return request({
    url: '/system/material/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getMaterial(materialId) {
  return request({
    url: '/system/material/' + materialId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addMaterial(data) {
  return request({
    url: '/system/material',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateMaterial(data) {
  return request({
    url: '/system/material',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delMaterial(materialId) {
  return request({
    url: '/system/material/' + materialId,
    method: 'delete'
  })
}
