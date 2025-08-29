ALTER TABLE bonds ADD COLUMN IF NOT EXISTS sell_date date;
alter table bonds alter column value_date drop not null;