from prefect import flow, task
import psycopg2
from prefect.blocks.system import JSON

redshift_credentials = JSON.load("redshift")
sql_query = open('sql/insert_into_dim_grade.sql').read()

def establish_connection():
    try:
        host = redshift_credentials.value['host']
        database = redshift_credentials.value['database']
        user = redshift_credentials.value['user']
        password = redshift_credentials.value['password']
        port = redshift_credentials.value['port']

        # Establish a connection
        conn = psycopg2.connect(
            host=host,
            database=database,
            user=user,
            password=password,
            port=port
        )
        return conn
    except psycopg2.Error as e:
        print("Error establishing a database connection:", e)
        return None

def insert_into_dim_grade(conn, sql_query):
    try:
        cursor = conn.cursor() 
        cursor.execute(sql_query) 
        conn.commit() 
        conn.close()
    except psycopg2.Error as e:
        print("Error executing SQL query:", e)

@task
def to_dim_grade():
    conn = establish_connection()
    if conn is not None:
        insert_into_dim_grade(conn, sql_query)

@flow()
def to_dim_grade_flow():
    to_dim_grade()

if __name__ == "__main__":
    to_dim_grade_flow.serve(name="to_dim_grade")
