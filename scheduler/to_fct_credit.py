from prefect import flow, task
from redshift_connector import RedshiftConnection

sql_query = open('sql/insert_to_fct_credit.sql').read()
executer = RedshiftConnection()

@task
def to_fct_credit():
    executer.execute_query(sql_query)

@flow()
def to_fct_credit_flow():
    to_fct_credit()

if __name__ == "__main__":
    to_fct_credit_flow.serve(
        name="to_fct_credit",
        cron="50  0 * * *",
        tags=["gold", "dim_grade"],
        description="Fetch data from silver stage to dim_fct_grade of gold stage",
        version="dw-credit/deployments"
    )
