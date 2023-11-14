CREATE TABLE dev.gold.dim_status (
    sk INTEGER NOT NULL IDENTITY(1, 1) ENCODE raw,
    loan_status VARCHAR(255) ENCODE lzo,
    inserted_time TIMESTAMP DEFAULT GETDATE(),
    PRIMARY KEY (sk)
) DISTSTYLE AUTO SORTKEY (sk);