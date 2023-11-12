CREATE OR REPLACE PROCEDURE dev.gold.payment_to_sk(
    IN total_pymnt REAL,
    IN total_pymnt_inv REAL,
    IN last_pymnt_d DATE,
    IN last_pymnt_amnt REAL,
    IN next_pymnt_d DATE,
    OUT payment_sk INT
)
AS $$
BEGIN
  -- Your logic here
  SELECT sk INTO payment_sk FROM dev.gold.dim_payment WHERE
   total_pymnt = total_pymnt 
   AND total_pymnt_inv = total_pymnt_inv 
   AND last_pymnt_d = last_pymnt_d 
   AND last_pymnt_amnt = last_pymnt_amnt 
   AND next_pymnt_d = next_pymnt_d;
END;
$$ LANGUAGE plpgsql;


