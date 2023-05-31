import psycopg2
from logging import info

class library():

    def connect(self):
        return psycopg2.connect(
            host='',
            database='',
            user='',
            password=''
        )
 
    def remove_student(self, email):
        query = "delete from students where email = '{}'".format(email)

        info(query)
        conn = self.connect()
        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()
    
    def remove_student_by_name(self, name):
        query = "delete from students where name LIKE '%{}%'".format(name)

        info(query)
        conn = self.connect()
        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()
    
    def insert_student(self, student):
        self.remove_student(student['email'])

        query = ("insert into students (name, email, age, weight, feet_tall, created_at, updated_at)"
                 "values('{}','{}',{},{},{}, now(), now());"
                 .format(student['name'], student['email'], student['age'], student['weight'], student['feet_tall']))
        
        info(query)
        conn = self.connect()
        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()
    
    def remove_plan(self, title):
        query = "delete from plans where title = '{}'".format(title)

        info(query)
        conn = self.connect()
        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()

    def insert_plan(self, plan):
        self.remove_plan(plan['title'])

        query = ("insert into plans (title, duration, price, created_at, updated_at)"
                 "values('{}',{},{}, now(), now());"
                 .format(plan['title'], plan['duration'], plan['price']))
        
        info(query)
        conn = self.connect()
        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()