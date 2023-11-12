from botocore.exceptions import NoCredentialsError
from prefect import flow, task
import psycopg2
import pandas as pd

sql_query = open('sql/copy_from_s3.sql').read()

def establish_connection():
    try:
        host = 'dw-loan.c8eysn3nvdo8.eu-north-1.redshift.amazonaws.com'
        database = 'dev'
        user = 'awsuser'
        password = 'Strongpassword1'
        port = '5439'

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

def copy_data_to_redshift(conn, sql_query):
    try:
        cursor = conn.cursor() 
        cursor.execute(sql_query) 
        conn.commit() 
        conn.close()
    except psycopg2.Error as e:
        print("Error executing SQL query:", e)

@task
def to_bronze():
    conn = establish_connection()
    if conn is not None:
        copy_data_to_redshift(conn, sql_query)

@flow()
def to_bronze_flow():
    to_bronze()

if __name__ == "__main__":
    to_bronze_flow.serve(name="to_bronze")