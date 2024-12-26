from flask import Flask
from flask_cors import CORS
from flask import Flask, request, jsonify

import arranger
import calculater
app = Flask(__name__)

CORS(app)

arg=arranger.arranger(homework_id=1)
cal=calculater.Calculater()

@app.route('/arrange_homework', methods=['POST'])
def homework():
    try:
        data = request.get_json()
        if 'judge_num' not in data or 'homework_id' not in data:
            return jsonify({'error': 'Missing parameter: judge_num or homework_id'}), 400

        # 动态更新 homework_id
        arg.homework_id = data['homework_id']

        # 调用 arrange 方法
        arg.arrange(data['judge_num'])
        return jsonify({'message': 'Homework arranged successfully'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/post_score', methods=['POST'])
def post_score():
    try:
        data = request.get_json()  # data 是一个列表
        if not isinstance(data, list):
            return jsonify({'error': 'Invalid data format, expected a list'}), 400

        homework_id = None  # 用于存储作业 ID

        for score_entry in data:
            # 逐个处理评分
            arg.score(
                judger=score_entry['judger'],
                bejudger=score_entry['bejudger'],
                homework_id=score_entry['homework_id'],
                score=score_entry['score']
            )
            # 获取 homework_id（假设列表中的作业 ID 是一致的）
            if homework_id is None:
                homework_id = score_entry['homework_id']

        # 调用计算接口
        if homework_id is not None:
            cal.calculate(homework_id)
            return jsonify({'message': '评分提交成功，并完成计算！'}), 200
        else:
            return jsonify({'error': '无法获取作业 ID，无法进行计算！'}), 400

    except Exception as e:
        return jsonify({'error': str(e)}), 500



@app.route('/calculate',methods=['POST'])
def calculate():
    data=request.get_json()
    cal.calculate(data['homework_id'])
    return

if __name__ == '__main__':
    app.run(debug=True,port='5000')
