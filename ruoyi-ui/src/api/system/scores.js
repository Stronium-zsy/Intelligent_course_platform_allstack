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

// 获取需要互评的作业
export function getReviewTasks(query) {
  return request({
    url: "/system/scores/reviewTasks",
    method: "get",
    params: query,
  });
}

// 提交评分给 Flask
export function submitScoresToFlask(data) {
  return axios.post('http://127.0.0.1:5000/post_score', data);
}
