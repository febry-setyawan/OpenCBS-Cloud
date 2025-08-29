ALTER TABLE day_closures
  alter column end_time drop not null, ADD COLUMN IF NOT EXISTS error_message varchar(200),
  add column failed boolean default false,
  add column main_process boolean default false;