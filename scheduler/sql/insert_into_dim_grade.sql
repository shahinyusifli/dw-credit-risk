INSERT INTO dev.gold.dim_grade 
(grade, sub_grade)
(
    SELECT 
    grade, sub_grade
    FROM dev.silver.loans
    WHERE (grade, sub_grade) 
    NOT IN (SELECT grade, sub_grade FROM dev.gold.dim_grade)

);
