import pandas as pd
import sqlite3

create_table_query = open('DDL/tables/loans.sql').read()

try:
    conn = sqlite3.connect('loans.db')


    conn.execute(create_table_query)

    # Read CSV file
    df = pd.read_csv('loans.csv')

    # Define table name
    table_name = 'loans'

    # Write DataFrame to SQLite
    df.to_sql(table_name, conn, if_exists='replace', index=False)

    # Commit the transaction
    conn.commit()

except sqlite3.Error as e:
    print(f"SQLite error: {e}")

except pd.errors.EmptyDataError:
    print("The CSV file is empty.")

except pd.errors.ParserError as pe:
    print(f"Error parsing CSV file: {pe}")

except Exception as ex:
    print(f"An unexpected error occurred: {ex}")

finally:
    if conn:
        conn.close()
