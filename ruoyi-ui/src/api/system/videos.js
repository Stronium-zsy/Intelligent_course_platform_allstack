import request from '@/utils/request'

// 查询课程视频列表
export function listVideos(query) {
  return request({
    url: '/system/videos/list',
    method: 'get',
    params: query
  })
}

// 查询课程视频详细
export function getVideos(id) {
  return request({
    url: '/system/videos/' + id,
    method: 'get'
  })
}

// 新增课程视频
export function addVideos(data) {
  return request({
    url: '/system/videos',
    method: 'post',
    data: data
  })
}

// 修改课程视频
export function updateVideos(data) {
  return request({
    url: '/system/videos',
    method: 'put',
    data: data
  })
}

// 删除课程视频
export function delVideos(id) {
  return request({
    url: '/system/videos/' + id,
    method: 'delete'
  })
}
