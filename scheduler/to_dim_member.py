from prefect import flow, task
from redshift_connector import RedshiftConnection

sql_query = open('sql/merge_into_dim_member.sql').read()
executer = RedshiftConnection()

@task
def to_dim_member():
    executer.execute_query(sql_query)

@flow()
def to_dim_member_flow():
    to_dim_member()

if __name__ == "__main__":
    to_dim_member_flow.serve(
        name="to_dim_member",
        cron="30  0 * * *",
        tags=["gold", "dim_member"],
        description="Fetch data from silver stage to dim_member of gold stage",
        version="dw-credit/deployments",
    )
