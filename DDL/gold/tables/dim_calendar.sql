CREATE TABLE dev.gold.dim_calendar (
    date_key DATE NOT NULL,
    day INTEGER,
    month INTEGER,
    month_name VARCHAR(20),
    year INTEGER,
    quarter INTEGER,
    weekday INTEGER,
    day_of_week_name VARCHAR(20),
    is_weekend BOOLEAN,
    CONSTRAINT date_dimension_pkey PRIMARY KEY (date_key)
) DISTSTYLE AUTO SORTKEY (date_key);