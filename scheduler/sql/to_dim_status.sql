INSERT INTO dev.gold.dim_status 
(loan_status)
(
    SELECT 
    DISTINCT loan_status
    FROM dev.silver.loans
    WHERE (loan_status) 
    NOT IN (SELECT distinct loan_status FROM dev.gold.dim_status )
);
