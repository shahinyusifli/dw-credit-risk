from prefect import flow, task
from redshift_connector import RedshiftConnection

sql_query = open('sql/upsert_bronze_to_silver.sql').read()
executer = RedshiftConnection()

@task
def to_silver():
    executer.execute_query(sql_query)

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
