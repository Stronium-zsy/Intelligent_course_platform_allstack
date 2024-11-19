import request from '@/utils/request'

export function getFolderStructure(courseId) {
  return request({
    url: '/system/folder/structure' ,
    method: 'get',
    params: {courseId}
  })
}
