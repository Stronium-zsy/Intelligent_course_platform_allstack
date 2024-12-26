import pymysql
from sympy.utilities.iterables import generate_derangements as derangements
class arranger:
    def __init__(self,homework_id,num_to_judge=1):
        self.homework_id=homework_id
        self.conn=pymysql.connect(host='localhost',
                             user='root',
                             passwd='204825',
                             database='intelligent_course_platform',
                             port=3306)
        self.judge_num=num_to_judge
        self.already={}
        return 
    
    def check(self,student,scheme):
        for i,stui in enumerate(student):
            if(stui not in self.already):
                self.already[stui]=[]
            
            if(scheme[i] in self.already[stui]):
                return True
            
        for i,stui in enumerate(student):
            self.already[stui].append(scheme[i])
        return False

    def arrange(self,num_to_judge=1):
        self.already.clear()
        self.judge_num=num_to_judge
        cursor=self.conn.cursor()
        sql=f"DELETE from Scores where homework_id={self.homework_id}"
        cursor.execute(sql)
        self.conn.commit()
        sql='SELECT user_id FROM course_user WHERE role = "STUDENT" '
        cursor.execute(sql)
        res=cursor.fetchall()
        students=[int(i[0]) for i in res]
        students=list(set(students))
        print(students)
        if(self.judge_num>=len(students)):
            self.judge_num=len(students)-1

        result = list(derangements(students))
        cnt=0
        for _ in range(self.judge_num):
            
            resulti = tuple(result[cnt])
            while(True):
                bol=self.check(students,resulti)
                if(bol==False):
                    break
                cnt=cnt+1
                resulti = tuple(result[cnt])
            
            for i in range(len(students)):
                judger=students[i]
                bejudger=resulti[i]
                sql=f"INSERT INTO Scores (scorer,bescorer,homework_id) VALUES  ({judger},{bejudger},{self.homework_id})"
                cursor.execute(sql)
        # cursor.execute('select * from Scores')
        # res=cursor.fetchall()
        print(res)
        self.conn.commit()
        cursor.close()
        return
    
    def score(self,judger,bejudger,homework_id,score):
        sql=f'update Scores set score ={score} where scorer={judger} and bescorer={bejudger} and homework_id={homework_id} '
        cursor=self.conn.cursor()
        cursor.execute(sql)
        self.conn.commit()
        return
    
if __name__ == '__main__':
    arg=arranger(3)
    arg.arrange()
    arg.score('126','127',2,90)
    arg.score('126','137',2,90)
    arg.score('126','164',2,90)
    arg.score('127','126',2,90)

