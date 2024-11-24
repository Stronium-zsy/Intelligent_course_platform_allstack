import request from '../../../../../Intelligent_course_platform/ruoyi-ui/src/utils/request'

// 查询【请填写功能名称】列表
export function listSubmissions(query) {
  return request({
    url: '/system/submissions/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getSubmissions(submissionId) {
  return request({
    url: '/system/submissions/' + submissionId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addSubmissions(data) {
  return request({
    url: '/system/submissions',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateSubmissions(data) {
  return request({
    url: '/system/submissions',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delSubmissions(submissionId) {
  return request({
    url: '/system/submissions/' + submissionId,
    method: 'delete'
  })
}
