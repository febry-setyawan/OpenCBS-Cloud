ALTER TABLE loan_products ADD COLUMN IF NOT EXISTS top_up_allow boolean not null default false;
ALTER TABLE loan_products ADD COLUMN IF NOT EXISTS top_up_max_limit numeric(14, 2) null;
ALTER TABLE loan_products ADD COLUMN IF NOT EXISTS top_up_max_olb numeric(14, 2) null;