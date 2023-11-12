from prefect import flow, task
from redshift_connector import RedshiftConnection

sql_query = open('sql/insert_into_dim_ownership.sql').read()
executer = RedshiftConnection()

@task
def to_dim_ownership():
    executer.execute_query(sql_query)

@flow()
def to_dim_ownership_flow():
    to_dim_ownership()

if __name__ == "__main__":
    to_dim_ownership_flow.serve(
        name="to_dim_ownership",
        cron="35  0 * * *",
        tags=["gold", "dim_ownership"],
        description="Fetch data from silver stage to dim_ownership of gold stage",
        version="dw-credit/deployments"
    )
