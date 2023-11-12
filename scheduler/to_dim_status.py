from prefect import flow, task
from redshift_connector import RedshiftConnection

sql_query = open('sql/insert_into_dim_status.sql').read()
executer = RedshiftConnection()

@task
def to_dim_status():
    executer.execute_query(sql_query)

@flow()
def to_dim_status_flow():
    to_dim_status()

if __name__ == "__main__":
    to_dim_status_flow.serve(
        name="to_dim_status",
        cron="45  0 * * *",
        tags=["gold", "dim_status"],
        description="Fetch data from silver stage to dim_status of gold stage",
        version="dw-credit/deployments"
    )
