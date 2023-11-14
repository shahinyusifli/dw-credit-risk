-- Create a temporary table
CREATE TEMP TABLE temp_calendar_dates AS (
  WITH RECURSIVE calendar_dates(calendar_date) AS (
    SELECT 
      DATE '1995-01-01'
    UNION ALL
    SELECT 
      (calendar_date + INTERVAL '1 day')::DATE  -- Explicitly cast to DATE
    FROM 
      calendar_dates
    WHERE 
      calendar_date < DATE '2023-12-31' -- Adjust the end date as needed
  )
  SELECT 
    calendar_date,
    EXTRACT(day FROM calendar_date) AS day,
    EXTRACT(month FROM calendar_date) AS month,
    TO_CHAR(calendar_date, 'Month') AS month_name,
    EXTRACT(year FROM calendar_date) AS year,
    EXTRACT(quarter FROM calendar_date) AS quarter,
    EXTRACT(dow FROM calendar_date) AS weekday,
    TO_CHAR(calendar_date, 'Day') AS day_of_week_name,
    CASE WHEN EXTRACT(dow FROM calendar_date) IN (0, 6) THEN TRUE ELSE FALSE END AS is_weekend
  FROM 
    calendar_dates
);

-- Insert into the target table
INSERT INTO dev.gold.dim_calendar (
  date_key,
  day,
  month,
  month_name,
  year,
  quarter,
  weekday,
  day_of_week_name,
  is_weekend
)
SELECT 
  calendar_date,
  day,
  month,
  month_name,
  year,
  quarter,
  weekday,
  day_of_week_name,
  is_weekend
FROM 
  temp_calendar_dates;

-- Drop the temporary table
DROP TABLE temp_calendar_dates;
