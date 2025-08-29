-- noinspection SqlNoDataSourceInspectionForFile
CREATE TABLE IF NOT EXISTS profiles_accounts (
  id         bigserial primary key,
  profile_id int not null,
  account_id int not null
);

-- Use DO blocks to conditionally add constraints if they don't exist
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints 
        WHERE constraint_name = 'profiles_accounts_profile_id_fkey'
        AND table_name = 'profiles_accounts'
    ) THEN
        ALTER TABLE profiles_accounts 
        ADD CONSTRAINT profiles_accounts_profile_id_fkey 
        FOREIGN KEY (profile_id) REFERENCES profiles (id);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints 
        WHERE constraint_name = 'profiles_accounts_account_id_fkey'
        AND table_name = 'profiles_accounts'
    ) THEN
        ALTER TABLE profiles_accounts 
        ADD CONSTRAINT profiles_accounts_account_id_fkey 
        FOREIGN KEY (account_id) REFERENCES accounts (id);
    END IF;
END $$;

--alter table accounts drop constraint accounts_currency_id_fkey;
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints 
        WHERE constraint_name = 'accounts_number_key'
        AND table_name = 'accounts'
    ) THEN
        ALTER TABLE accounts ADD CONSTRAINT accounts_number_key UNIQUE(number);
    END IF;
END $$;

INSERT INTO accounts (number, "name", is_debit, parent_id, start_date, close_date, "type", lft, rgt, currency_id)
  SELECT '2000', 'Liability Accounts', false , null, '2017-01-01', null, 1, 0, 0, null
  WHERE NOT EXISTS (SELECT 1 FROM accounts WHERE number = '2000');

INSERT INTO accounts (number, "name", is_debit, parent_id, start_date, close_date, "type", lft, rgt, currency_id)
  SELECT '2100', 'Current Accounts', false , (SELECT id FROM accounts WHERE number = '2000' LIMIT 1), '2017-01-01', null, 2, 0, 0, null
  WHERE NOT EXISTS (SELECT 1 FROM accounts WHERE number = '2100');

INSERT INTO accounts (number, "name", is_debit, parent_id, start_date, close_date, "type", lft, rgt, currency_id)
  SELECT '2101', 'Current Account USD', false , (SELECT id FROM accounts WHERE number = '2100' LIMIT 1), '2017-01-01', null, 4, 0, 0, 1
  WHERE NOT EXISTS (SELECT 1 FROM accounts WHERE number = '2101');

INSERT INTO global_settings("name", "type", "value")
  SELECT 'DEFAULT_CURRENT_ACCOUNT_GROUP', 'TEXT', '2100'
  WHERE NOT EXISTS (SELECT 1 FROM global_settings WHERE name = 'DEFAULT_CURRENT_ACCOUNT_GROUP');

drop table if exists current_accounts;

