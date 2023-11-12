INSERT INTO dev.gold.dim_status 
(loan_status)
(
    SELECT 
    loan_status
    FROM dev.silver.loans
    WHERE (loan_status) 
    NOT IN (SELECT loan_status FROM dev.gold.dim_status )
);
