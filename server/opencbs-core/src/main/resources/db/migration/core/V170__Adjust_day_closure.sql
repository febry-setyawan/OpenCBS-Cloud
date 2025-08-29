alter table end_of_days rename to day_closures;
ALTER TABLE day_closures ADD COLUMN IF NOT EXISTS id bigserial primary key;
