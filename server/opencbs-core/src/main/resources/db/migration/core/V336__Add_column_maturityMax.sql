ALTER TABLE loan_products ADD COLUMN IF NOT EXISTS maturity_date_max date;

ALTER TABLE audit.loan_products_history ADD COLUMN IF NOT EXISTS maturity_date_max date;