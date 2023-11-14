INSERT INTO dev.gold.dim_grade 
(grade, sub_grade)
(
    SELECT 
    DISTINCT grade, sub_grade
    FROM dev.silver.loans
    WHERE (grade, sub_grade) 
    NOT IN (SELECT DISTINCT grade, sub_grade,  FROM dev.gold.dim_grade)

);
