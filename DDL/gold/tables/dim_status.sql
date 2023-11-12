CREATE TABLE dev.gold.dim_status (
    sk INTEGER NOT NULL IDENTITY(1, 1) ENCODE raw,
    verification_status VARCHAR(255) ENCODE lzo,
    loan_status VARCHAR(255) ENCODE lzo,
    PRIMARY KEY (sk)
) DISTSTYLE AUTO SORTKEY (sk);