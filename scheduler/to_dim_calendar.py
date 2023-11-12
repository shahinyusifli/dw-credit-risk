from prefect import flow, task
from redshift_connector import RedshiftConnection


sql_query = open('sql/generate_dim_calendar.sql').read()
executer = RedshiftConnection()

@task
def to_dim_calendar():
    executer.execute_query(sql_query)

@flow()
def to_dim_calendar_flow():
    to_dim_calendar()

if __name__ == "__main__":
    to_dim_calendar_flow.serve(name="to_dim_calendar")
