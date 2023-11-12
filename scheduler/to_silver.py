from prefect import flow, task
import psycopg2
from prefect.blocks.system import JSON

redshift_credentials = JSON.load("redshift")
sql_query = open('sql/upsert_bronze_to_silver.sql').read()

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

def upsert_bronze_to_silver(conn, sql_query):
    try:
        cursor = conn.cursor() 
        cursor.execute(sql_query) 
        conn.commit() 
        conn.close()
    except psycopg2.Error as e:
        print("Error executing SQL query:", e)

@task
def to_silver():
    conn = establish_connection()
    if conn is not None:
        upsert_bronze_to_silver(conn, sql_query)

@flow()
def to_silver_flow():
    to_silver()

if __name__ == "__main__":
    to_silver_flow.serve(
        name="to_silver",
        cron="20  0 * * *",
        tags=["silver", "silver stage"],
        description="Fetch data from bronze stage to gold stage",
        version="dw-credit/deployments"
    )
