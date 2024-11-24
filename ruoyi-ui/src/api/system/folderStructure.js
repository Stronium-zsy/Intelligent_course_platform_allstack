import request from '../../../../../Intelligent_course_platform/ruoyi-ui/src/utils/request'

export function getFolderStructure(courseId) {
  return request({
    url: '/system/folder/structure' ,
    method: 'get',
    params: {courseId}
  })
}
