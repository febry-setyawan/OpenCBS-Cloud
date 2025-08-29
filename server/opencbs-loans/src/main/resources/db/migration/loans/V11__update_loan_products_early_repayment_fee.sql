ALTER TABLE loan_products ADD COLUMN IF NOT EXISTS early_partial_repayment_fee_type varchar(50), ADD COLUMN IF NOT EXISTS early_partial_repayment_fee_value numeric(12, 4),
    add column early_total_repayment_fee_type varchar(50),
    add column early_total_repayment_fee_value numeric(12, 4);

ALTER TABLE audit.loan_products_history ADD COLUMN IF NOT EXISTS early_partial_repayment_fee_type varchar(50), ADD COLUMN IF NOT EXISTS early_partial_repayment_fee_value numeric(12, 4),
    add column early_total_repayment_fee_type varchar(50),
    add column early_total_repayment_fee_value numeric(12, 4);