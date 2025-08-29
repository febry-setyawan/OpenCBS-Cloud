ALTER TABLE term_deposits ADD COLUMN IF NOT EXISTS early_close_fee_flat decimal(14, 2);
ALTER TABLE term_deposits ADD COLUMN IF NOT EXISTS early_close_fee_rate decimal(14, 2);
