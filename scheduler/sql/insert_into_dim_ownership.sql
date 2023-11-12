INSERT INTO dev.gold.dim_ownership
(home_ownership)
(
    SELECT 
    distinct home_ownership
    FROM dev.silver.loans
    WHERE (home_ownership) 
    NOT IN (SELECT distinct home_ownership FROM dev.gold.dim_ownership )
);
