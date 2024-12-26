import request from '@/utils/request'

// 调用 Flask 的 /arrange_homework 接口
export function arrangeHomework(homeworkId, judgeNum = 2) {
    return request({
        url: 'http://127.0.0.1:5000/arrange_homework',
        method: 'post',
        data: {
            homework_id: homeworkId,
            judge_num: judgeNum // 默认为2
        }
    })
}
