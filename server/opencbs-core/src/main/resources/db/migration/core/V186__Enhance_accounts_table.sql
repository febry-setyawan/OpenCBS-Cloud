ALTER TABLE accounts ADD COLUMN IF NOT EXISTS locked                     boolean not null default false,
  add column allowed_transfer_from      boolean not null default true,
  add column allowed_transfer_to        boolean not null default true,
  add column allowed_cash_deposit       boolean not null default true,
  add column allowed_cash_withdrawal    boolean not null default true,
  add column allowed_manual_transaction boolean not null default true;