from prefect import flow, task
from redshift_connector import RedshiftConnection

sql_query = open('sql/merge_into_dim_payment.sql').read()
executer = RedshiftConnection()

@task
def to_dim_payment():
    executer.execute_query(sql_query)

@flow()
def to_dim_payment_flow():
    to_dim_payment()

if __name__ == "__main__":
    to_dim_payment_flow.serve(
        name="to_dim_payment",
        cron="40  0 * * *",
        tags=["gold", "dim_payment"],
        description="Fetch data from silver stage to dim_payment of gold stage",
        version="dw-credit/deployments"
    )
