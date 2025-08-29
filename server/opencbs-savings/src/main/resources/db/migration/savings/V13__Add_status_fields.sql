ALTER TABLE saving_products ADD COLUMN IF NOT EXISTS status varchar(10) default 'ACTIVE';
ALTER TABLE audit.saving_products_history ADD COLUMN IF NOT EXISTS status varchar(10) default 'ACTIVE'