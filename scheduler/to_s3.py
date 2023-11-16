import sqlite3
import pandas as pd
import boto3
from botocore.exceptions import NoCredentialsError
from prefect import flow, task
import psycopg2
import logging
import numpy as np
from prefect.blocks.system import JSON
from redshift_connector import RedshiftConnection

executer = RedshiftConnection()
s3_credentials = JSON.load("s3bucket")
query_select_ids = open('sql/select_ids_from_dw.sql').read()

conn = executer.establish_connection()

@task
def select_ids_from_dw():
    try:
        ids_from_dw = pd.read_sql(query_select_ids, conn)
        conn.close()
        return ids_from_dw
    except psycopg2.Error as psycopg_error:
        logging.error(f"Psycopg2 database error in select_ids_from_dw: {psycopg_error}")
        raise  # Re-raise the exception for better error handling further up the stack
    except Exception as e:
        logging.error(f"Error in select_ids_from_dw: {str(e)}")
        raise e

@task
def sql_table_to_csv(ids_from_dw):
    try:
        db_connection = sqlite3.connect('C:\\Users\\User_PC\\Desktop\\Portfolio projects\\credit-risk-model-dw\\dw-credit-risk\\source\\loans.db')
        # Adjust the query to select 10 rows from 'loans' where 'id' does not match values from 'select_ids_from_dw'
        query_select_10_loans = open('sql/select_top_10_loans.sql').read().format(','.join(map(str, ids_from_dw['id'])))

        df = pd.read_sql(query_select_10_loans, db_connection)
        numeric_columns = ["id", "member_id", "loan_amnt", "funded_amnt", "funded_amnt_inv", "int_rate",
                           "installment", "annual_inc", "dti", "delinq_2yrs", "inq_last_6mths",
                           "mths_since_last_delinq", "mths_since_last_record", "open_acc", "pub_rec",
                           "revol_bal", "revol_util", "total_acc", "out_prncp", "out_prncp_inv", "total_pymnt",
                           "total_pymnt_inv", "total_rec_prncp", "total_rec_int", "total_rec_late_fee", "recoveries", 
                           "collection_recovery_fee", "last_pymnt_amnt", "collections_12_mths_ex_med", 
                           "mths_since_last_major_derog", "policy_code", "annual_inc_joint"
                           ]
        
        df[numeric_columns] = df[numeric_columns].replace(np.nan, 0)
        df.to_csv('data/loans.csv', index=False, header=False)

        return "Success: Data exported to Parquet."
    except Exception as e:
        logging.error(f"Error in sql_table_to_parquet: {str(e)}")
        raise e

@task
def csv_to_s3_bucket():
    aws_access_key_id = s3_credentials.value["aws_access_key_id"]
    aws_secret_access_key = s3_credentials.value["aws_secret_access_key"]
    aws_region = s3_credentials.value["aws_region"]

    s3_bucket = 'loans-credit-risk'
    s3_key = 'loans.csv'

    try:
        s3 = boto3.client('s3', region_name=aws_region, aws_access_key_id=aws_access_key_id, aws_secret_access_key=aws_secret_access_key)
        s3.upload_file('data/loans.csv', s3_bucket, s3_key)
        return f'Success: Data uploaded to S3 bucket {s3_bucket}/{s3_key}'
    except NoCredentialsError:
        logging.error("AWS credentials not found.")
        raise
    except Exception as e:
        logging.error(f"Error in parquet_to_s3_bucket: {str(e)}")
        raise e

@flow()
def to_s3_flow():
    ids_from_dw = select_ids_from_dw()
    result_sql = sql_table_to_csv(ids_from_dw)
    if "Success" in result_sql:
        result_s3 = csv_to_s3_bucket()
        return result_s3
    else:
        return result_sql

if __name__ == "__main__":
    to_s3_flow.serve(
        name="csv_to_s3_bucket",
        cron="0 0 * * *",
        tags=["db", "bucket", "s3"],
        description="Flow fetch 10 rows from transactional db to s3 bucket",
        version="dw-credit/deployments"
    )
