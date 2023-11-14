INSERT INTO dev.gold.dim_payment 
(total_pymnt, total_pymnt_inv, last_pymnt_d,
    last_pymnt_amnt, next_pymnt_d)
(
    SELECT 
    distinct total_pymnt, total_pymnt_inv, last_pymnt_d,
    last_pymnt_amnt, next_pymnt_d
FROM dev.silver.loans
WHERE (total_pymnt, total_pymnt_inv, last_pymnt_d, last_pymnt_amnt, next_pymnt_d) 
    NOT IN (SELECT distinct total_pymnt, total_pymnt_inv, last_pymnt_d,
    last_pymnt_amnt, next_pymnt_d FROM dev.gold.dim_payment)

);
