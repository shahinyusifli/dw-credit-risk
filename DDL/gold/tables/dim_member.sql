CREATE TABLE dev.gold.dim_member (
    sk INTEGER NOT NULL IDENTITY(1, 1) ENCODE raw,
    id INTEGER,
    emp_length VARCHAR(255) ENCODE lzo,
    zip_code VARCHAR(255) ENCODE lzo,
    addr_state VARCHAR(255) ENCODE lzo,
    is_valid BOOLEAN DEFAULT True,
    inserted_time TIMESTAMP DEFAULT GETDATE(),
    updated_time TIMESTAMP DEFAULT NULL,
    PRIMARY KEY (sk)
) DISTSTYLE AUTO SORTKEY (sk);