# List a
a = ["id", "member_id", "loan_amnt", "funded_amnt", "funded_amnt_inv", "term", "int_rate", "installment", "grade",
     "sub_grade", "emp_length", "home_ownership", "annual_inc", "issue_d", "loan_status", "url", "purpose", "title",
     "zip_code", "addr_state", "dti", "delinq_2yrs", "earliest_cr_line", "inq_last_6mths", "mths_since_last_delinq",
     "mths_since_last_record", "open_acc", "pub_rec", "revol_bal", "revol_util", "total_acc", "initial_list_status",
     "out_prncp", "out_prncp_inv", "total_pymnt", "total_pymnt_inv", "total_rec_prncp", "total_rec_int",
     "total_rec_late_fee", "recoveries", "collection_recovery_fee", "last_pymnt_d", "last_pymnt_amnt", "next_pymnt_d",
     "last_credit_pull_d", "collections_12_mths_ex_med", "mths_since_last_major_derog", "policy_code",
     "application_type", "annual_inc_joint"]

# List b
b = ["id", "member_id", "loan_amnt", "funded_amnt", "funded_amnt_inv", "term", "int_rate", "installment", "grade",
     "sub_grade", "emp_title", "emp_length", "home_ownership", "annual_inc", "verification_status", "issue_d",
     "loan_status", "pymnt_plan", "url", "desc", "purpose", "title", "zip_code", "addr_state", "dti", "delinq_2yrs",
     "earliest_cr_line", "inq_last_6mths", "mths_since_last_delinq", "mths_since_last_record", "open_acc", "pub_rec",
     "revol_bal", "revol_util", "total_acc", "initial_list_status", "out_prncp", "out_prncp_inv", "total_pymnt",
     "total_pymnt_inv", "total_rec_prncp", "total_rec_int", "total_rec_late_fee", "recoveries",
     "collection_recovery_fee", "last_pymnt_d", "last_pymnt_amnt", "next_pymnt_d", "last_credit_pull_d",
     "collections_12_mths_ex_med", "mths_since_last_major_derog", "policy_code", "application_type", "annual_inc_joint",
     "dti_joint", "verification_status_joint", "acc_now_delinq", "tot_coll_amt", "tot_cur_bal", "open_acc_6m",
     "open_il_6m", "open_il_12m", "open_il_24m", "mths_since_rcnt_il", "total_bal_il", "il_util", "open_rv_12m",
     "open_rv_24m", "max_bal_bc", "all_util", "total_rev_hi_lim", "inq_fi", "total_cu_tl", "inq_last_12m"]

# Convert lists to sets and find the difference
difference = set(b) - set(a)

# Print the result
print("Values in list a but not in list b:", difference)
