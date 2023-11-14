CREATE TABLE dev.gold.dim_ownership (
    sk INTEGER NOT NULL IDENTITY(1, 1) ENCODE raw,
    home_ownership VARCHAR(255) ENCODE lzo,
    inserted_time TIMESTAMP DEFAULT GETDATE(),
    PRIMARY KEY (sk)
) DISTSTYLE AUTO SORTKEY (sk);