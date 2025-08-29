INSERT INTO day_closure_contracts(contract_id, process_type, actual_date, branch_id)
SELECT id, 'LOAN_PENALTY_ACCRUAL', disbursement_date, branch_id
FROM loans
WHERE disbursement_date IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM day_closure_contracts 
    WHERE contract_id = loans.id AND process_type = 'LOAN_PENALTY_ACCRUAL'
  );