CREATE TABLE dev.gold.dim_grade (
    sk INTEGER NOT NULL IDENTITY(1, 1) ENCODE raw,
    grade VARCHAR(255) ENCODE lzo,
    sub_grade VARCHAR(255) ENCODE lzo,
    inserted_time TIMESTAMP DEFAULT GETDATE(),
    PRIMARY KEY (sk)
) DISTSTYLE AUTO SORTKEY (sk);