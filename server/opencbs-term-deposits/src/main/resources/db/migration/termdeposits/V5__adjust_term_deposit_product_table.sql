ALTER TABLE term_deposit_products ADD COLUMN IF NOT EXISTS early_close_fee_flat_min decimal(14, 2);
ALTER TABLE term_deposit_products ADD COLUMN IF NOT EXISTS early_close_fee_flat_max decimal(14, 2);
ALTER TABLE term_deposit_products ADD COLUMN IF NOT EXISTS early_close_fee_rate_min decimal(14, 2);
ALTER TABLE term_deposit_products ADD COLUMN IF NOT EXISTS early_close_fee_rate_max decimal(14, 2);