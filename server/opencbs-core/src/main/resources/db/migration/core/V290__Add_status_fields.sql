ALTER TABLE loan_products ADD COLUMN IF NOT EXISTS status varchar(10) default 'ACTIVE';
ALTER TABLE audit.loan_products_history ADD COLUMN IF NOT EXISTS status varchar(10) default 'ACTIVE'