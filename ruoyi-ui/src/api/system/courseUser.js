import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listCourseUser(query) {
  return request({
    url: '/system/course_user/list',
    method: 'get',
    params: query
  })
}

// 查询全部选课用户列表
export function listUserName(query){
  return request({
    url: '/system/course_user/userName_list',
    method: 'get',
    params: query
  })
}

// 查询其余学生列表
export function listOtherStu(query) {
  return request({
    url: '/system/course_user/stu_list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getCourseUser(courseId) {
  return request({
    url: '/system/course_user/' + courseId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addCourseUser(data) {
  return request({
    url: '/system/course_user',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateCourseUser(data) {
  return request({
    url: '/system/course_user',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delCourseUser(courseId, userId) {
  return request({
    url: `/system/course_user/${courseId}/${userId}`,
    method: 'delete'
  })
}
