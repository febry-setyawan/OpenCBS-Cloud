ALTER TABLE accounts ADD COLUMN IF NOT EXISTS off_balance boolean not null default false;

update accounts
  set off_balance = true
where number = '8001';