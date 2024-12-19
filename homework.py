from flask import Flask
from flask_cors import CORS
from flask import Flask, request, jsonify

import arranger
import calculater
app = Flask(__name__)

CORS(app)

arg=arranger.arranger()
cal=calculater.Calculater()

@app.route('/arrange_homework',methods=['POST'])
def homework():
    data = request.get_json()
    arg.arrange(data['judge_num'])
    return

@app.route('/post_score',methods=['POST'])
def post_score():
    data=request.get_json()
    arg.score(judger=data['judger'],
              bejudger=data['bejudger'],
              homework_id=data['homework_id'],
              score=data['score'])
    return

@app.route('/calculate',methods=['POST'])
def calculate():
    data=request.get_json()
    cal.calculate(data['homework_id'])
    return

if __name__ == '__main__':
    app.run(debug=True,port='5000')
