CREATE TABLE dev.gold.dim_status (
    sk INTEGER NOT NULL IDENTITY(1, 1) ENCODE raw,
    loan_status VARCHAR(255) ENCODE lzo,
    PRIMARY KEY (sk)
) DISTSTYLE AUTO SORTKEY (sk);