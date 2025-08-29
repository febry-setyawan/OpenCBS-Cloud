ALTER TABLE entry_fees ADD COLUMN IF NOT EXISTS account_id integer references accounts(id);

update entry_fees set account_id = 32;

alter table entry_fees alter column account_id set not null;