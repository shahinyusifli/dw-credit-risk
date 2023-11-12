MERGE INTO dev.gold.dim_member
USING dev.silver.loans ON gold.dim_member.id = silver.loans.member_id
WHEN MATCHED THEN 
    UPDATE SET
        is_valid = False,
        valid_to = CURRENT_DATE    
WHEN NOT MATCHED THEN 
    INSERT (
        id, emp_length, zip_code, addr_state, is_valid, valid_from 
    )    
    VALUES (
        silver.loans.member_id, silver.loans.emp_length, silver.loans.zip_code,
        silver.loans.addr_state, True, CURRENT_DATE
    );
