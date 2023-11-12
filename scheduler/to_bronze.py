from prefect import flow, task
from redshift_connector import RedshiftConnection

sql_query = open('sql/copy_from_s3.sql').read()
executer = RedshiftConnection()

@task
def to_bronze():
    executer.execute_query(sql_query)

@flow()
def to_bronze_flow():
    to_bronze()

if __name__ == "__main__":
    to_bronze_flow.serve(
        name="to_bronze",
        cron="15 0 * * *",
        tags=["s3", "bucket", "bronze"],
        description="Flow copy data file from bucket to bronze stage of dw",
        version="dw-credit/deployments"
    )
