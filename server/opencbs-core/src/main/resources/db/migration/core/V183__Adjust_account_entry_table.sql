ALTER TABLE accounting_entries ADD COLUMN IF NOT EXISTS debit_account_balance decimal(14, 4);
ALTER TABLE accounting_entries ADD COLUMN IF NOT EXISTS credit_account_balance decimal(14, 4);

update accounting_entries
set credit_account_balance = 0,
    debit_account_balance  = 0;

alter table accounting_entries
    alter column credit_account_balance set not null;
alter table accounting_entries
    alter column debit_account_balance set not null;