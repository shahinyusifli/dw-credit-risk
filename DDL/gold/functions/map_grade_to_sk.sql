CREATE OR REPLACE PROCEDURE dev.gold.grade_to_sk(
  IN grade VARCHAR,
  IN sub_grade VARCHAR,
  OUT status_sk INT
)
AS $$
BEGIN
  -- Your logic here
  SELECT sk INTO status_sk FROM dev.gold.dim_grade WHERE grade=grade and sub_grade=sub_grade;
END;
$$ LANGUAGE plpgsql;