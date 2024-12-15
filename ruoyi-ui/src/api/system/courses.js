import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listCourses(query) {
  return request({
    url: '/system/courses/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getCourses(courseId) {
  return request({
    url: '/system/courses/' + courseId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addCourses(data) {
  return request({
    url: '/system/courses',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateCourses(data) {
  return request({
    url: '/system/courses',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delCourses(courseId) {
  return request({
    url: '/system/courses/' + courseId,
    method: 'delete'
  })
}
