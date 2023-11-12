from prefect import flow, task
from redshift_connector import RedshiftConnection
from prefect.blocks.system import JSON

s3_credentials = JSON.load("s3bucket")

sql_query = """
COPY dev.bronze.loans
FROM 's3://loans-credit-risk/loans.csv'
CREDENTIALS 'aws_access_key_id={0};aws_secret_access_key={1}'
FORMAT AS CSV;
""".format(s3_credentials.value["aws_access_key_id"], s3_credentials.value["aws_secret_access_key"])

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
