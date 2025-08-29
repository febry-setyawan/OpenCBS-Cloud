ALTER TABLE saving_products ADD COLUMN IF NOT EXISTS min_balance decimal(14, 2);

update saving_products
set
  min_balance = 5000;