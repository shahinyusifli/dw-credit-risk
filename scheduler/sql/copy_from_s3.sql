-- Load data from the CSV file into a Redshift table using access and secret keys
COPY dev.bronze.loans
FROM 's3://loans-credit-risk/loans.csv'
CREDENTIALS 'aws_access_key_id=AKIAYJ3CX5YVP65WHAGN;aws_secret_access_key=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'
FORMAT AS CSV;