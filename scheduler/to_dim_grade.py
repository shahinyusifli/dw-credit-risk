from prefect import flow, task
from redshift_connector import RedshiftConnection

sql_query = open('sql/insert_into_dim_grade.sql').read()
executer = RedshiftConnection()

@task
def to_dim_grade():
    executer.execute_query(sql_query)

@flow()
def to_dim_grade_flow():
    to_dim_grade()

if __name__ == "__main__":
    to_dim_grade_flow.serve(
        name="to_dim_grade",
        cron="25  0 * * *",
        tags=["gold", "dim_grade"],
        description="Fetch data from silver stage to dim_grade gold stage",
        version="dw-credit/deployments"
)
