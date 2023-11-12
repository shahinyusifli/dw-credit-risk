import pandas as pd
import sqlite3

# Create a connection to the SQLite database
conn = sqlite3.connect('loans.db')  # Replace with your database name

# Read the CSV file into a Pandas DataFrame
df = pd.read_csv('loans.csv')  # Replace with your CSV file path

# Define the table name
table_name = 'loans'

# Write the DataFrame to the SQLite database
df.to_sql(table_name, conn, if_exists='replace', index=False)

# Commit the changes and close the connection
conn.commit()
conn.close()
