WITH ranked_loans AS (
                SELECT *,
                       ROW_NUMBER() OVER (ORDER BY id) AS row_num
                FROM loans
                WHERE id NOT IN ({})
),
not_more_10_ranked_laons as (
                SELECT * FROM ranked_loans WHERE row_num <= 10
)

SELECT 
id, member_id, loan_amnt, funded_amnt, funded_amnt_inv, term,        
int_rate, installment, grade, sub_grade, emp_length, home_ownership,
annual_inc, verification_status, issue_d, loan_status, url, purpose,
title, zip_code, addr_state, dti, delinq_2yrs, earliest_cr_line, 
inq_last_6mths, mths_since_last_delinq, mths_since_last_record, open_acc,
pub_rec, revol_bal, revol_util, total_acc, initial_list_status,
out_prncp, out_prncp_inv, total_pymnt, total_pymnt_inv, total_rec_prncp,
total_rec_int, total_rec_late_fee, recoveries, collection_recovery_fee, 
last_pymnt_d, last_pymnt_amnt, next_pymnt_d, last_credit_pull_d,
collections_12_mths_ex_med, mths_since_last_major_derog, policy_code,
application_type,annual_inc_joint            
FROM not_more_10_ranked_laons;