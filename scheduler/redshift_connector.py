import psycopg2
from prefect.blocks.system import JSON

class RedshiftConnection:
    def __init__(self):
        self.credentials = JSON.load("redshift")

    def establish_connection(self):
        try:
            host = self.credentials.value['host']
            database = self.credentials.value['database']
            user = self.credentials.value['user']
            password = self.credentials.value['password']
            port = self.credentials.value['port']

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

    def execute_query(self, sql_query):
        try:
            conn = self.establish_connection()
            cursor = conn.cursor()
            cursor.execute(sql_query)
            conn.commit()
            conn.close()
        except psycopg2.Error as e:
            print("Error executing SQL query:", e)