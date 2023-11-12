CREATE OR REPLACE PROCEDURE dev.gold.status_to_sk(
  IN verification_status VARCHAR,
  IN loan_status VARCHAR,
  OUT status_sk INT
)
AS $$
BEGIN
  -- Your logic here
  SELECT sk INTO status_sk FROM dev.gold.dim_status WHERE verification_status = verification_status and loan_status=loan_status;
END;
$$ LANGUAGE plpgsql;