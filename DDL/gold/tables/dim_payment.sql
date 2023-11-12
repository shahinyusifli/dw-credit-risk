CREATE TABLE dev.gold.dim_payment (
    sk INTEGER NOT NULL IDENTITY(1, 1) ENCODE raw,
    pymnt_plan VARCHAR(255) ENCODE lzo,
    total_pymnt REAL ENCODE raw,
    total_pymnt_inv REAL ENCODE raw,
    last_pymnt_d DATE REFERENCES dev.gold.dim_calendar(date_key),
    last_pymnt_amnt REAL ENCODE raw,
    next_pymnt_d DATE REFERENCES dev.gold.dim_calendar(date_key)
    PRIMARY KEY (sk)
) DISTSTYLE AUTO SORTKEY (sk);