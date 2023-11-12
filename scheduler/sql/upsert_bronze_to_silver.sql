    MERGE INTO dev.silver.loans
    USING dev.bronze.loans ON silver.loans.id = bronze.loans.id
    WHEN MATCHED THEN 
    UPDATE SET
            id = CAST(bronze.loans.id AS INTEGER),
            member_id = CAST(bronze.loans.member_id AS INTEGER),
            loan_amnt = CAST(bronze.loans.loan_amnt AS DECIMAL(10, 2)),
            funded_amnt = CAST(bronze.loans.funded_amnt AS DECIMAL(10, 2)),
            funded_amnt_inv = CAST(bronze.loans.funded_amnt_inv AS DECIMAL(10, 7)),
            term = bronze.loans.term,
            int_rate = CAST(bronze.loans.int_rate AS DECIMAL(10, 2)),
            installment = CAST(bronze.loans.installment AS DECIMAL(10, 2)),
            grade = bronze.loans.grade,
            sub_grade = bronze.loans.sub_grade,
            emp_length = bronze.loans.emp_length,
            home_ownership = bronze.loans.home_ownership,
            annual_inc = CAST(bronze.loans.annual_inc AS DECIMAL(10, 2)),
            issue_d = TO_DATE(CONCAT('01-', bronze.loans.issue_d), 'DD-Mon-YYYY'),
            loan_status = bronze.loans.loan_status,
            url = bronze.loans.url,
            purpose = bronze.loans.purpose,
            title = bronze.loans.title,
            zip_code = bronze.loans.zip_code,
            addr_state = bronze.loans.addr_state,
            dti = CAST(bronze.loans.dti AS DECIMAL(10, 2)),
            delinq_2yrs = CAST(bronze.loans.delinq_2yrs AS DECIMAL(10, 2)),
            earliest_cr_line = TO_DATE(CONCAT('01-', bronze.loans.earliest_cr_line), 'DD-Mon-YYYY'),
            inq_last_6mths = CAST(bronze.loans.inq_last_6mths AS DECIMAL(10, 2)),
            mths_since_last_delinq = CAST(bronze.loans.mths_since_last_delinq AS DECIMAL(10, 2)),
            mths_since_last_record = CAST(bronze.loans.mths_since_last_record AS DECIMAL(10, 2)),
            open_acc = CAST(bronze.loans.open_acc AS DECIMAL(10, 2)),
            pub_rec = CAST(bronze.loans.pub_rec AS DECIMAL(10, 2)),
            revol_bal = CAST(bronze.loans.revol_bal AS DECIMAL(10, 2)),
            revol_util = CAST(bronze.loans.revol_util AS DECIMAL(10, 2)),
            total_acc = CAST(bronze.loans.total_acc AS DECIMAL(10, 2)),
            initial_list_status = bronze.loans.initial_list_status,
            out_prncp = CAST(bronze.loans.out_prncp AS DECIMAL(10, 2)),
            out_prncp_inv = CAST(bronze.loans.out_prncp_inv AS DECIMAL(10, 2)),
            total_pymnt = CAST(bronze.loans.total_pymnt AS DECIMAL(10, 2)),
            total_pymnt_inv = CAST(bronze.loans.total_pymnt_inv AS DECIMAL(10, 2)),
            total_rec_prncp = CAST(bronze.loans.total_rec_prncp AS DECIMAL(10, 2)),
            total_rec_int = CAST(bronze.loans.total_rec_int AS DECIMAL(10, 2)),
            total_rec_late_fee = CAST(bronze.loans.total_rec_late_fee AS DECIMAL(10, 2)),
            recoveries = CAST(bronze.loans.recoveries AS DECIMAL(10, 2)),
            collection_recovery_fee = CAST(bronze.loans.collection_recovery_fee AS DECIMAL(10, 2)),
            last_pymnt_d = TO_DATE(CONCAT('01-', bronze.loans.last_pymnt_d), 'DD-Mon-YYYY'),
            last_pymnt_amnt = CAST(bronze.loans.last_pymnt_amnt AS DECIMAL(10, 2)),
            next_pymnt_d = TO_DATE(CONCAT('01-', bronze.loans.next_pymnt_d), 'DD-Mon-YYYY'),
            last_credit_pull_d = TO_DATE(CONCAT('01-', bronze.loans.last_credit_pull_d), 'DD-Mon-YYYY'),
            collections_12_mths_ex_med = CAST(bronze.loans.collections_12_mths_ex_med AS DECIMAL(10, 2)),
            mths_since_last_major_derog = CAST(bronze.loans.mths_since_last_major_derog AS DECIMAL(10, 2)),
            policy_code = CAST(bronze.loans.policy_code AS DECIMAL(10, 2)),
            application_type = bronze.loans.application_type,
            annual_inc_joint = CAST(bronze.loans.annual_inc_joint AS DECIMAL(10, 2))
    WHEN NOT MATCHED THEN 
    INSERT (
            id, member_id, loan_amnt, funded_amnt, funded_amnt_inv, term, int_rate, installment, grade, sub_grade, emp_length,
            home_ownership, annual_inc, issue_d, loan_status, url, purpose, title, zip_code, addr_state, dti, delinq_2yrs,
            earliest_cr_line, inq_last_6mths, mths_since_last_delinq, mths_since_last_record, open_acc, pub_rec, revol_bal,
            revol_util, total_acc, initial_list_status, out_prncp, out_prncp_inv, total_pymnt, total_pymnt_inv, total_rec_prncp,
            total_rec_int, total_rec_late_fee, recoveries, collection_recovery_fee, last_pymnt_d, last_pymnt_amnt, next_pymnt_d,
            last_credit_pull_d, collections_12_mths_ex_med, mths_since_last_major_derog, policy_code, application_type, annual_inc_joint
        )
        VALUES (
        CAST(bronze.loans.id AS INTEGER), 
        CAST(bronze.loans.member_id AS INTEGER), 
        CAST(bronze.loans.loan_amnt AS DECIMAL(10, 2)), 
        CAST(bronze.loans.funded_amnt AS DECIMAL(10, 2)), 
        CAST(bronze.loans.funded_amnt_inv AS DECIMAL(10, 2)), 
        bronze.loans.term, 
        CAST(bronze.loans.int_rate AS DECIMAL(10, 2)), 
        CAST(bronze.loans.installment AS DECIMAL(10, 2)), 
        bronze.loans.grade, 
        bronze.loans.sub_grade, 
        bronze.loans.emp_length, 
        bronze.loans.home_ownership, 
        CAST(bronze.loans.annual_inc AS DECIMAL(10, 2)), 
        TO_DATE(CONCAT('01-', bronze.loans.issue_d), 'DD-Mon-YYYY'), 
        bronze.loans.loan_status, 
        bronze.loans.url, 
        bronze.loans.purpose, 
        bronze.loans.title, 
        bronze.loans.zip_code, 
        bronze.loans.addr_state, 
        CAST(bronze.loans.dti AS DECIMAL(10, 2)), 
        CAST(bronze.loans.delinq_2yrs AS DECIMAL(10, 2)), 
        TO_DATE(CONCAT('01-', bronze.loans.earliest_cr_line), 'DD-Mon-YYYY'), 
        CAST(bronze.loans.inq_last_6mths AS DECIMAL(10, 2)), 
        CAST(bronze.loans.mths_since_last_delinq AS DECIMAL(10, 2)), 
        CAST(bronze.loans.mths_since_last_record AS DECIMAL(10, 2)), 
        CAST(bronze.loans.open_acc AS DECIMAL(10, 2)), 
        CAST(bronze.loans.pub_rec AS DECIMAL(10, 2)), 
        CAST(bronze.loans.revol_bal AS DECIMAL(10, 2)), 
        CAST(bronze.loans.revol_util AS DECIMAL(10, 2)), 
        CAST(bronze.loans.total_acc AS DECIMAL(10, 2)), 
        bronze.loans.initial_list_status, 
        CAST(bronze.loans.out_prncp AS DECIMAL(10, 2)), 
        CAST(bronze.loans.out_prncp_inv AS DECIMAL(10, 2)), 
        CAST(bronze.loans.total_pymnt AS DECIMAL(10, 2)), 
        CAST(bronze.loans.total_pymnt_inv AS DECIMAL(10, 2)), 
        CAST(bronze.loans.total_rec_prncp AS DECIMAL(10, 2)), 
        CAST(bronze.loans.total_rec_int AS DECIMAL(10, 2)), 
        CAST(bronze.loans.total_rec_late_fee AS DECIMAL(10, 2)), 
        CAST(bronze.loans.recoveries AS DECIMAL(10, 2)), 
        CAST(bronze.loans.collection_recovery_fee AS DECIMAL(10, 2)), 
        TO_DATE(CONCAT('01-', bronze.loans.last_pymnt_d), 'DD-Mon-YYYY'), 
        CAST(bronze.loans.last_pymnt_amnt AS DECIMAL(10, 2)), 
        TO_DATE(CONCAT('01-', bronze.loans.next_pymnt_d), 'DD-Mon-YYYY'), 
        TO_DATE(CONCAT('01-', bronze.loans.last_credit_pull_d), 'DD-Mon-YYYY'), 
        CAST(bronze.loans.collections_12_mths_ex_med AS DECIMAL(10, 2)), 
        CAST(bronze.loans.mths_since_last_major_derog AS DECIMAL(10, 2)), 
        CAST(bronze.loans.policy_code AS DECIMAL(10, 2)), 
        bronze.loans.application_type, 
        CAST(bronze.loans.annual_inc_joint AS DECIMAL(10, 2))
    );
