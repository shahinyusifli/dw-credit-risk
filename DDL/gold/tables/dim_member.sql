CREATE TABLE dev.gold.dim_member (
    sk INTEGER NOT NULL IDENTITY(1, 1) ENCODE raw,
    id INTEGER,
    emp_length VARCHAR(255) ENCODE lzo,
    zip_code VARCHAR(255) ENCODE lzo,
    addr_state VARCHAR(255) ENCODE lzo,
    is_valid BOOLEAN,
    valid_to DATE,
    valid_from DATE,
    PRIMARY KEY (sk)
) DISTSTYLE AUTO SORTKEY (sk);