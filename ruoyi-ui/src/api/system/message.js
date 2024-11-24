import request from '../../../../../Intelligent_course_platform/ruoyi-ui/src/utils/request'

// 查询【请填写功能名称】列表
export function listMessage(query) {
  return request({
    url: '/system/message/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getMessage(messageId) {
  return request({
    url: '/system/message/' + messageId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addMessage(data) {
  return request({
    url: '/system/message',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateMessage(data) {
  return request({
    url: '/system/message',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delMessage(messageId) {
  return request({
    url: '/system/message/' + messageId,
    method: 'delete'
  })
}
