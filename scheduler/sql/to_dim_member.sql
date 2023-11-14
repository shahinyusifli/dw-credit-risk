MERGE INTO dev.gold.dim_member
USING dev.silver.loans ON gold.dim_member.id = silver.loans.member_id
WHEN MATCHED THEN 
    UPDATE SET
        is_valid = False,
        updated_time = GETDATE()    
WHEN NOT MATCHED THEN 
    INSERT (
        id, emp_length, zip_code, addr_state 
    )    
    VALUES (
        silver.loans.member_id, silver.loans.emp_length, silver.loans.zip_code,
        silver.loans.addr_state
    );
