import pymysql
class Calculater:
    def __init__(self):
        self.conn=pymysql.connect(host='localhost',
                                  user='root',
                                  passwd='204825',
                                  database='intelligent_course_platform',
                                  port=3306)
        self.p_map={}
        self.score_map={}#一个人被其他人的打分情况
        self.p_update={}
        self.score_end={}
        return

    def get_bad_val(self,studenti:map):
        total=0
        bad_score={}
        good_score={}
        for scorer,score in studenti.items():
            if(score==-1):
                continue
            total+=score
        mean=total/len(studenti)
        sigma=0
        for scorer,score in studenti.items():
            sigma+=(score-mean)**2
        sigma/=len(studenti)
        sigma=sigma**0.5

        for scorer,score in studenti.items():

            if(abs(score-mean)>3*sigma or score==-1):
                bad_score[scorer]=score
            else:
                good_score[scorer]=score
        return good_score,bad_score



    def calculate(self,homework_id):
        sql = "select * from p_table"
        cursor=self.conn.cursor()
        cursor.execute(sql)
        student_p=cursor.fetchall()
        for it in student_p:
            self.p_map[it[0]]=it[1]
        print(self.p_map)

        sql=f"select * from Scores where homework_id = {homework_id}"
        cursor.execute(sql)
        exchange_s=cursor.fetchall()
        for it in exchange_s:
            scorer=it[0]
            bescore=it[1]
            score=it[3]
            if(bescore not in self.score_map):
                self.score_map[bescore]={}
            self.score_map[bescore][scorer]=score

        for studenti,scores in self.score_map.items():
            good_score,bad_score=self.get_bad_val(scores)
            summ=0
            psum=0
            for goods,score in good_score.items():
                if(goods not in self.p_update):
                    self.p_update[goods]=0
                self.p_update[goods]+=1
                summ+=score*self.p_map[goods]
                psum+=self.p_map[goods]

            # 如果 psum 为 0，则跳过此学生的计算
            if psum == 0:
                print(f"学生 {studenti} 没有有效评分，跳过计算")
                continue
            self.score_end[studenti]=summ/psum

        for stud,p in self.p_update.items():
            new_p=p+self.p_map[stud]
            sql=f'update p_table set P={new_p} where student_id={stud}'
            cursor.execute(sql)

        for stud,score in self.score_end.items():
            sql=f'update homework_submissions set grade={score} where homework_id={homework_id} and user_id={stud}'
            cursor.execute(sql)

        self.conn.commit()

        return

if __name__=="__main__":
    cal=Calculater()
    cal.calculate(2)